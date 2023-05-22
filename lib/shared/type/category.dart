import 'package:get/get.dart';

class Category {
  int id;
  String name;
  String image_url;
  int order;
  String created_at;
  String updated_at;

  Category(
      {required this.id,
      required this.name,
      required this.image_url,
      required this.order,
      required this.created_at,
      required this.updated_at});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      image_url: json['image_url'] as String,
      order: json['order'] as int,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );
  }
}

class ResponseCategory {
  List<Category> items = <Category>[].obs;
  ResponseCategory({required this.items});

  factory ResponseCategory.fromJson(Map<String, dynamic> json) {
    List<Category> newItems = json['categories']
        .map<Category>((el) => Category.fromJson(el))
        .toList();
    return ResponseCategory(items: newItems);
  }
}
