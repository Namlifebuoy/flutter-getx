import 'dart:ffi';
import 'dart:convert';
import 'package:get/get.dart';

// class Categories {
//   late int id;
//   late String name;
// }

class Meta {
  int totalCount;
  int pageCount;
  int currentPage;
  int perPage;

  Meta({
    required this.totalCount,
    required this.pageCount,
    required this.currentPage,
    required this.perPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
        totalCount: json['totalCount'],
        pageCount: json['pageCount'],
        currentPage: json['currentPage'],
        perPage: json['perPage']);
  }
}

class DataBug {
  List<Bug> items;
  Meta meta;

  DataBug({
    required this.items,
    required this.meta,
  });
}

class Bug {
  int id; //
  String name; //
  List<Article> article; //
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
    handleCategories() {
      return json['categories']
          .map<Categories>((el) => Categories.fromJson(el))
          .toList();
    }

    handleArticle() {
      return json['article']
          .map<Article>((el) => Article.fromJson(el))
          .toList();
    }

    return Bug(
      id: json['id'] as int,
      name: json['name'] as String,
      image_url: json['image_url'] as String,
      is_favorite: json['is_favorite'] as bool,
      description: json['description'] as String,
      article: json['article'] == null ? [] : handleArticle(),
      categories: json['categories'] == null ? [] : handleCategories(),
    );
  }

  factory Bug.fromJson2(Map<String, dynamic> json) {
    handleCategories() {
      return json['categories']
          .map<Categories>((el) => Categories.fromJson(jsonDecode(el)))
          .toList();
    }

    handleArticle() {
      return json['article']
          .map<Article>((el) => Article.fromJson(jsonDecode(el)))
          .toList();
    }

    return Bug(
      id: json['id'] as int,
      name: json['name'] as String,
      image_url: json['image_url'] as String,
      is_favorite: json['is_favorite'] as bool,
      description: json['description'] as String,
      article: json['article'] == null ? [] : handleArticle(),
      categories: json['categories'] == null ? [] : handleCategories(),
    );
  }

  String toJson() {
    return json.encode({
      "id": id,
      "name": name,
      "image_url": image_url,
      "is_favorite": is_favorite,
      "description": description,
      "article": article.map((a) {
        return a.toJson();
      }).toList(),
      "categories": categories.map((a) {
        return a.toJson();
      }).toList(),
    });
  }
}

class Article {
  String type;
  String content;

  Article({
    required this.type,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      type: json['type'] as String,
      content: json['content'] as String,
    );
  }

  String toJson() {
    return json.encode({
      "type": type,
      "content": content,
    });
  }
}

class Categories {
  int id;
  String name;

  Categories({
    required this.id,
    required this.name,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  // factory Categories.fromJson2(String data) {
  //   return Categories(id: data['id'], meta: metaData);
  // }

  String toJson() {
    return json.encode({
      "id": id,
      "name": name,
    });
  }
}

class ResponseBug {
  List<Bug> items = <Bug>[].obs;
  Meta meta;
  ResponseBug({
    required this.items,
    required this.meta,
  });

  factory ResponseBug.fromJson(Map<String, dynamic> json) {
    List<Bug> newItems =
        json['items'].map<Bug>((el) => Bug.fromJson(el)).toList();
    Meta metaData = Meta.fromJson(json['_meta']);
    return ResponseBug(items: newItems, meta: metaData);
  }
}
