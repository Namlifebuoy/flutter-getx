import 'dart:convert';

import 'package:firstgetx/shared/type/bug.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../type/blog.dart';
import '../type/blog_detail.dart';
import '../type/category.dart';

class HomeStore extends GetxController {
  List<Blog> arrBlog = <Blog>[].obs;
  late BlogDetail blogDetail;
  List<Category> arrCategory = <Category>[].obs;
  late ResponseBug arrCurrentCategory;
  late ResponseBug arrSearchAll;
  late Bug currentBugDetail;
  var isLoading = true.obs;
  var isLoadMore = true.obs;
  var indexCategory = 0;
  var countPage = 1.obs;

  HomeStore() {
    getBlogFromApi(1);
    getCategoryFromApi();
  }

  addPage() {
    countPage = countPage + 1;
  }

  getBlogFromApi(int countBlog) async {
    try {
      final response = await http.get(Uri.parse(
          'https://insectscan.dataplazma.com/api/v1/articles?page=$countBlog&per_page=20'));
      if (response.statusCode == 200) {
        final jsonTo = json.decode(response.body);
        final signUp = ResponseBlog.fromJson(jsonTo);
        arrBlog.addAll(signUp.items);
        update();
      } else {
        throw "API call failed with status code: ${response.statusCode}.";
      }
    } catch (e) {
      print("ERR: getBlogFromApi error: $e");
    }
  }

  getCategoryFromApi() async {
    try {
      final response = await http
          .get(Uri.parse('https://insectscan.dataplazma.com/api/v1/reference'));
      if (response.statusCode == 200) {
        final jsonTo = json.decode(response.body);
        final signUp = ResponseCategory.fromJson(jsonTo);
        arrCategory = signUp.items;
        // print(arrCategory);
        update();
      } else {
        throw "API call failed with status code: ${response.statusCode}.";
      }
    } catch (e) {
      print("ERR: getBlogFromApi error: $e");
    }
  }

  getDetailCategoryFromApi(int index, {String? key}) async {
    indexCategory = index;
    try {
      var response = await http.get(Uri.parse(key != null
          ? 'https://insectscan.dataplazma.com/api/v1/items?page=1&per_page=30&category_id=$index&search=$key'
          : 'https://insectscan.dataplazma.com/api/v1/items?page=1&per_page=30&category_id=$index&search='));
      if (response.statusCode == 200) {
        final jsonTo = json.decode(response.body);
        final signUp = ResponseBug.fromJson(jsonTo);
        arrCurrentCategory = signUp;
        // print("hihi: ${jsonTo}");
        update();
      } else {
        throw "API call failed with status code: ${response.statusCode}.";
      }
    } catch (e) {
      print("ERR: getDetailCategoryFromApi error: $e");
    }
  }

  getSearchAllDetailCategory(int index, {String? key = ''}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://insectscan.dataplazma.com/api/v1/items?page=$index&per_page=20&search=$key'));
      if (response.statusCode == 200) {
        final jsonTo = json.decode(response.body);
        final signUp = ResponseBug.fromJson(jsonTo);
        if (index == 1) {
          arrSearchAll = signUp;
        } else if (index > 1) {
          arrSearchAll.items.addAll(signUp.items);
        }
        // for (int i = 0; i < arrSearchAll.items.length; i++) {
        //   print("Search ${arrSearchAll.items[i].name}");
        // }
        if (arrSearchAll.items.length < arrSearchAll.meta.totalCount) {
          isLoadMore.value = true;
        }
        update();
      } else {
        throw "API call failed with status code: ${response.statusCode}.";
      }
    } catch (e) {
      print("ERR: getSearchAllDetailCategory error: $e");
    }
    isLoading.value = false;
  }

  getDetailBlog(int index) async {
    try {
      final response = await http.get(Uri.parse(
          'https://insectscan.dataplazma.com/api/v1/articles/$index'));
      if (response.statusCode == 200) {
        final jsonTo = json.decode(response.body);
        final signUp = BlogDetail.fromJson(jsonTo);
        blogDetail = signUp;
        print(blogDetail);
        update();
      } else {
        throw "API call failed with status code: ${response.statusCode}.";
      }
    } catch (e) {
      print("ERR: getBlogFromApi error: $e");
    }
  }

  getDetailBug(int index) async {
    try {
      final response = await http.get(
          Uri.parse('https://insectscan.dataplazma.com/api/v1/items/$index'));
      if (response.statusCode == 200) {
        final jsonTo = json.decode(response.body);
        final signUp = Bug.fromJson(jsonTo);
        currentBugDetail = signUp;
        // print("getDetailBug: $jsonTo");
        update();
      } else {
        throw "API call failed with status code: ${response.statusCode}.";
      }
    } catch (e) {
      print("ERR: getBlogFromApi error: $e");
    }
  }
}
