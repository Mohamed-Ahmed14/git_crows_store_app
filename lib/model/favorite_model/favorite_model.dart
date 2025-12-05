import 'package:clothing_store/model/product_model/product_model.dart';

class FavoriteModel {
  String? id;
  String? createdAt;
  bool? isFavorite;
  String? userId;
  String? productId;
  ProductModel? product;

  FavoriteModel(
      {this.id,
        this.createdAt,
        this.isFavorite,
        this.userId,
        this.productId,
        this.product});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    isFavorite = json['is_favorite'];
    userId = json['user_id'];
    productId = json['product_id'];
    product = json['products'] != null
        ?  ProductModel.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['is_favorite'] = isFavorite;
    data['user_id'] = userId;
    data['product_id'] = productId;
    if (product != null) {
      data['products'] = product!.toJson();
    }
    return data;
  }
}

// class Products {
//   String? id;
//   String? desc;
//   String? name;
//   int? price;
//   int? stock;
//   String? imgUrl;
//   String? category;
//   int? discount;
//   String? createdAt;
//   bool? isPopular;
//   bool? isRecommended;
//   String? lastUpdatedAt;
//   int? priceAfterDiscount;
//
//   Products(
//       {this.id,
//         this.desc,
//         this.name,
//         this.price,
//         this.stock,
//         this.imgUrl,
//         this.category,
//         this.discount,
//         this.createdAt,
//         this.isPopular,
//         this.isRecommended,
//         this.lastUpdatedAt,
//         this.priceAfterDiscount});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     desc = json['desc'];
//     name = json['name'];
//     price = json['price'];
//     stock = json['stock'];
//     imgUrl = json['img_url'];
//     category = json['category'];
//     discount = json['discount'];
//     createdAt = json['created_at'];
//     isPopular = json['is_popular'];
//     isRecommended = json['is_recommended'];
//     lastUpdatedAt = json['last_updated_at'];
//     priceAfterDiscount = json['price_after_discount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['desc'] = desc;
//     data['name'] = name;
//     data['price'] = price;
//     data['stock'] = stock;
//     data['img_url'] = imgUrl;
//     data['category'] = category;
//     data['discount'] = discount;
//     data['created_at'] = createdAt;
//     data['is_popular'] = isPopular;
//     data['is_recommended'] = isRecommended;
//     data['last_updated_at'] = lastUpdatedAt;
//     data['price_after_discount'] = priceAfterDiscount;
//     return data;
//   }
//}