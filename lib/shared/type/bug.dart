import 'dart:ffi';

import 'package:get/get.dart';

class Categories {
  late int id;
  late String name;
}

class Bug {
  int id; //
  String name; //
  dynamic article; //
  String image_url; //
  String description; //
  List categories; //
  bool is_favorite; //
  String? customName;
  bool? fromCollection;
  Array? images;
  String? created_at;
  String? updated_at;
  String? wiki_link;

  Bug({
    required this.id,
    required this.name,
    required this.article,
    required this.image_url,
    required this.description,
    required this.categories,
    required this.is_favorite,
    this.customName,
    this.fromCollection,
    this.images,
    this.created_at,
    this.updated_at,
    this.wiki_link,
  });

  factory Bug.fromJson(Map<String, dynamic> json) {
    return Bug(
      id: json['id'] as int,
      name: json['name'] as String,
      image_url: json['image_url'] as String,
      article: json['article'] as dynamic,
      description: json['description'] as String,
      categories: json['categories'] as List,
      is_favorite: json['is_favorite'] as bool,
    );
  }
}

class ResponseBug {
  List<Bug> items = <Bug>[].obs;
  ResponseBug({required this.items});

  factory ResponseBug.fromJson(Map<String, dynamic> json) {
    List<Bug> newItems =
        json['items'].map<Bug>((el) => Bug.fromJson(el)).toList();
    return ResponseBug(items: newItems);
  }
}
