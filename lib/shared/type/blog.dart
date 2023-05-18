import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Blog {
  int id;
  dynamic body;
  dynamic tags;
  String image_url;
  String title;

  Blog({
    required this.id,
    required this.body,
    required this.tags,
    required this.image_url,
    required this.title,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] as int,
      body: json['body'] == null ? '' : json['body'] as String,
      tags: json['tags'] == null ? [] : json['tags'] as dynamic,
      image_url: json['image_url'] as String,
      title: json['title'] as String,
    );
  }
}

class ResponseBlog {
  List<Blog> items = <Blog>[].obs;
  ResponseBlog({required this.items});

  factory ResponseBlog.fromJson(Map<String, dynamic> json) {
    List<Blog> newItems =
        json['items'].map<Blog>((el) => Blog.fromJson(el)).toList();
    return ResponseBlog(items: newItems);
  }
}
