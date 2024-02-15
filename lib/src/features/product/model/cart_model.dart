class CartModel {
  int? id;
  int? productId;
  int? userId;
  String? slug;
  String? url;
  String? title;
  String? content;
  String? image;
  String? thumbnail;
  String? status;
  String? category;

  CartModel(
      this.id,
      this.productId,
      this.userId,
      this.slug,
      this.url,
      this.title,
      this.content,
      this.image,
      this.thumbnail,
      this.status,
      this.category);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (id != null) {
      map['id'] = id;
    }
    map["productId"] = productId;
    map["userId"] = userId;
    map["slug"] = slug;
    map["url"] = url;
    map["title"] = title;
    map["content"] = content;
    map["image"] = image;
    map["thumbnail"] = thumbnail;
    map["status"] = status;
    map["category"] = category;
    return map;
  }

  CartModel.fromMapObject(Map<String, dynamic> map) {
    id = map["id"];
    productId = map["productId"];
    userId = map["userId"];
    slug = map["slug"];
    url = map["url"];
    title = map["title"];
    content = map["content"];
    image = map["image"];
    thumbnail = map["thumbnail"];
    status = map["status"];
    category = map["category"];
  }
}
