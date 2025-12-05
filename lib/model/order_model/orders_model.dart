class OrdersModel {
  String? id;
  String? createdAt;
  String? userId;
  String? paymentMethod;
  int? paymobOrderId;
  String? shippingMethod;
  int? subtotal;
  int? shippingFees;
  int? total;
  String? status;
  String? fullName;
  String? email;
  String? phone;
  String? city;
  String? address;

  OrdersModel(
      {this.id,
        this.createdAt,
        this.userId,
        this.paymentMethod,
        this.paymobOrderId,
        this.shippingMethod,
        this.subtotal,
        this.shippingFees,
        this.total,
        this.status,
        this.fullName,
        this.email,
        this.phone,
        this.city,
        this.address});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    paymentMethod = json['payment_method'];
    paymobOrderId = json['paymob_order_id'];
    shippingMethod = json['shipping_method'];
    subtotal = json['subtotal'];
    shippingFees = json['shipping_fees'];
    total = json['total'];
    status = json['status'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    data['payment_method'] = paymentMethod;
    data['paymob_order_id'] = paymobOrderId;
    data['shipping_method'] = shippingMethod;
    data['subtotal'] = subtotal;
    data['shipping_fees'] = shippingFees;
    data['total'] = total;
    data['status'] = status;
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['city'] = city;
    data['address'] = address;
    return data;
  }
}
