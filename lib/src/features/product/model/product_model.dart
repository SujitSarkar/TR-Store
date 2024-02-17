import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  final int? id;
  final String? slug;
  final String? url;
  final String? title;
  final String? content;
  final String? image;
  final String? thumbnail;
  final String? status;
  final String? category;
  final int? userId;

  ProductModel({
    this.id,
    this.slug,
    this.url,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.status,
    this.category,
    this.userId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    slug: json["slug"],
    url: json["url"],
    title: json["title"],
    content: json["content"],
    image: json["image"],
    thumbnail: json["thumbnail"],
    status: json["status"],
    category: json["category"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "url": url,
    "title": title,
    "content": content,
    "image": image,
    "thumbnail": thumbnail,
    "status": status,
    "category": category,
    "userId": userId,
  };
}
