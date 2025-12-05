class CartItemModel {
  String? id;
  String? createdAt;
  String? userId;
  String? productId;
  String? name;
  String? imageUrl;
  int? quantity;
  int? price;
  String? size;
  String? color;
  int? piecePrice; // Assuming this is the price per piece, not used in the original code

  CartItemModel(
      {this.id,
        this.createdAt,
        this.userId,
        this.productId,
        this.quantity,
        this.price,
        this.size,
        this.color,
      this.name,
      this.imageUrl,
      this.piecePrice});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    productId = json['product_id'];
    name = json['name'];
    imageUrl = json['img_url'];
    quantity = json['quantity'];
    price = json['price'];
    size = json['size'];
    color = json['color'];
    piecePrice = json['piece_price']; // Assuming this is the price per piece
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['name'] = name;
    data['img_url'] = imageUrl;
    data['quantity'] = quantity;
    data['price'] = price;
    data['size'] = size;
    data['color'] = color;
    data['piece_price'] = piecePrice; // Assuming this is the price per piece
    return data;
  }
}