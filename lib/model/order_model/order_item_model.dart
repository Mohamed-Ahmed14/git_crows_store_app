import 'package:clothing_store/model/cart_model/cart_item_model.dart';

class OrderItemModel extends CartItemModel{

  String? orderId;
  OrderItemModel({
    this.orderId,
    super.id,
    super.createdAt,
    super.userId,
    super.productId,
    super.name,
    super.imageUrl,
    super.quantity,
    super.price,
    super.size,
    super.color,
    super.piecePrice, // Assuming this is the price per piece
  });

  OrderItemModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    orderId = json['order_id'];
  }

  @override
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = super.toJson();
    data['order_id'] = orderId;
    return data;
  }
}