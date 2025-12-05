class ProductDetailsModel {
  String? id;
  String? createdAt;
  String? lastUpdatedAt;
  String? name;
  String? category;
  String? desc;
  int? stock;
  int? price;
  int? discount;
  int? priceAfterDiscount;
  String? imgUrl;
  bool? isPopular;
  bool? isRecommended;
  List<Favorites>? favorites;

  ProductDetailsModel(
      {this.id,
        this.createdAt,
        this.lastUpdatedAt,
        this.name,
        this.category,
        this.desc,
        this.stock,
        this.price,
        this.discount,
        this.priceAfterDiscount,
        this.imgUrl,
        this.isPopular,
        this.isRecommended,
        this.favorites});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    lastUpdatedAt = json['last_updated_at'];
    name = json['name'];
    category = json['category'];
    desc = json['desc'];
    stock = json['stock'];
    price = json['price'];
    discount = json['discount'];
    priceAfterDiscount = json['price_after_discount'];
    imgUrl = json['img_url'];
    isPopular = json['is_popular'];
    isRecommended = json['is_recommended'];
    if (json['favorites'] != null) {
      favorites = [];
      json['favorites'].forEach((v) {
        favorites!.add(Favorites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['last_updated_at'] = lastUpdatedAt;
    data['name'] = name;
    data['category'] = category;
    data['desc'] = desc;
    data['stock'] = stock;
    data['price'] = price;
    data['discount'] = discount;
    data['price_after_discount'] = priceAfterDiscount;
    data['img_url'] = imgUrl;
    data['is_popular'] = isPopular;
    data['is_recommended'] = isRecommended;
    if (favorites != null) {
      data['favorites'] = favorites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favorites {
  String? id;
  String? userId;
  String? createdAt;
  String? productId;
  bool? isFavorite;

  Favorites(
      {this.id, this.userId, this.createdAt, this.productId, this.isFavorite});

  Favorites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    productId = json['product_id'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['product_id'] = productId;
    data['is_favorite'] = isFavorite;
    return data;
  }
}