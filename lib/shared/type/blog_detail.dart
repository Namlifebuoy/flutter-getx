import 'dart:ffi';

import 'package:get/get.dart';

class BlogDetail {
  // id?: number;
  // title?: string;
  // image_url?: string;
  // tags?: any;
  // body?: [
  //   {
  //     type: string;
  //     content: string;
  //   },
  // ];
  // created_at?: string;
  // updated_at?: string;
  int id;
  String title;
  String image_url;
  dynamic body;
  dynamic tags;
  String created_at;
  String updated_at;

  BlogDetail({
    required this.id,
    required this.title,
    required this.image_url,
    required this.body,
    required this.tags,
    required this.created_at,
    required this.updated_at,
  });

  factory BlogDetail.fromJson(Map<String, dynamic> json) {
    // List<BodyBlogDetail> blogDetail = <BodyBlogDetail>[];
    handleBody() {
      return json['body']
          .map<BodyBlogDetail>((el) => BodyBlogDetail.fromJson(el))
          .toList();
    }

    return BlogDetail(
      id: json['id'] as int,
      title: json['title'] as String,
      image_url: json['image_url'] as String,
      body: json['body'] == null ? '' : handleBody(),
      tags: json['tags'] == null ? [] : json['tags'] as dynamic,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );
  }
}

class BodyBlogDetail {
  String type;
  String content;

  BodyBlogDetail({
    required this.type,
    required this.content,
  });

  factory BodyBlogDetail.fromJson(Map<String, dynamic> json) {
    return BodyBlogDetail(
      type: json['type'] as String,
      content: json['content'] as String,
    );
  }
}
