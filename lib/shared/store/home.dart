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
  List<Bug> arrCurrentCategory = <Bug>[].obs;
  var isLoading = true.obs;
  var indexCategory = 0;

  HomeStore() {
    getBlogFromApi();
    getCategoryFromApi();
  }

  getBlogFromApi() async {
    try {
      final response = await http.get(Uri.parse(
          'https://insectscan.dataplazma.com/api/v1/articles?page=1&per_page=10'));
      if (response.statusCode == 200) {
        final jsonTo = json.decode(response.body);
        final signUp = ResponseBlog.fromJson(jsonTo);
        arrBlog = signUp.items;
        // print(arrBlog);
        update();
      } else {
        throw "API call failed with status code: ${response.statusCode}.";
      }
    } catch (e) {
      // Handle error
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
      // Handle error
      print("ERR: getBlogFromApi error: $e");
    }
  }

  getDetailCategoryFromApi(int index, {String? key}) async {
    indexCategory = index;
    try {
      var response = await http.get(Uri.parse(key != null
          ? 'https://insectscan.dataplazma.com/api/v1/items?page=1&per_page=20&category_id=${index}&search=${key}'
          : 'https://insectscan.dataplazma.com/api/v1/items?page=1&per_page=20&category_id=${index}&search='));
      if (response.statusCode == 200) {
        final jsonTo = json.decode(response.body);
        final signUp = ResponseBug.fromJson(jsonTo);
        arrCurrentCategory = signUp.items;
        for (int i = 0; i < arrCurrentCategory.length; i++) {
          print(arrCurrentCategory[i].name);
        }
        update();
      } else {
        throw "API call failed with status code: ${response.statusCode}.";
      }
    } catch (e) {
      // Handle error
      print("ERR: getCategoryFromApi error: $e");
    }
  }

  getDetailBlog(int index) async {
    try {
      final response = await http.get(Uri.parse(
          'https://insectscan.dataplazma.com/api/v1/articles/${index}'));
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
      // Handle error
      print("ERR: getBlogFromApi error: $e");
    }
  }
}
