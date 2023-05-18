import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../type/blog.dart';

class HomeStore extends GetxController {
  List<Blog> arrBlog = <Blog>[].obs;

  HomeStore() {
    getBlogFromApi();
  }

  getBlogFromApi() async {
    try {
      final response = await http.get(Uri.parse(
          'https://insectscan.dataplazma.com/api/v1/articles?page=1&per_page=10'));
      if (response.statusCode == 200) {
        final abc = json.decode(response.body);
        final signUp = ResponseBlog.fromJson(abc);
        arrBlog = signUp.items;
        print(arrBlog);
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
