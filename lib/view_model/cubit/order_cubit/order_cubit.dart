import 'dart:developer';
import 'package:clothing_store/model/cart_model/cart_item_model.dart';
import 'package:clothing_store/model/order_model/order_enum.dart';
import 'package:clothing_store/model/product_model/product_details_model.dart';
import 'package:clothing_store/view_model/data/network/dio_helper.dart';
import 'package:clothing_store/view_model/data/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utilities/sensitive_data.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitState());
  static OrderCubit get(context) => BlocProvider.of<OrderCubit>(context);

  var client = Supabase.instance.client.auth.currentUser;
  //Cart related variables can be added here
  List<CartItemModel> cartItems = [];
  int totalCartPrice = 0;
  //Cart related methods can be added here
Future<void> getCartItems() async {

   cartItems.clear();
   totalCartPrice = 0;
   emit(GetCartItemsLoadingState());
    try{
      var response = await DioHelper.get(endPoint: EndPoints.cart,
        queryParameters: {
        'user_id':"eq.${client?.id}"
        });
      for(var item in response.data){
        cartItems.add(CartItemModel.fromJson(item));
        totalCartPrice += int.parse(item['price'].toString());
      }
      emit(GetCartItemsSuccessState());
    }catch(e){
      emit(GetCartItemsErrorState());
    }
  }

Future<void> addToCart({required ProductDetailsModel product,required String size,required String color}) async {
  emit(AddToCartLoadingState());
    try {
      var response = await DioHelper.post(endPoint: EndPoints.cart,
      body: {
        'user_id': client?.id,
        'product_id': product.id,
        'name': product.name,
        'img_url': product.imgUrl,
        'quantity': 1,
        'piece_price': product.priceAfterDiscount,
        'size': size,
        'color': color,
        'price': (product.priceAfterDiscount ?? 0) * 1, // Assuming quantity is 1 for simplicity
      });
        emit(AddToCartSuccessState());

    } catch (e) {
      log('Error adding to cart: $e');
      emit(AddToCartErrorState());
      rethrow;
    }
  }

Future<void>  removeFromCart({required String cartItemId}) async {
  emit(RemoveFromCartLoadingState());
    try {
      var response = await DioHelper.delete(endPoint: EndPoints.cart,
      queryParameters: {
        'id':"eq.$cartItemId"
      });
      totalCartPrice -= cartItems.firstWhere((item) => item.id == cartItemId).price ?? 0;
      cartItems.removeWhere((item) => item.id == cartItemId);
      emit(RemoveFromCartSuccessState());
    } catch (e) {
      log('Error removing from cart: $e');
      emit(RemoveFromCartErrorState());
    }
  }

void increaseCartItemQuantity({required String cartItemId}) async{
  var index = cartItems.indexWhere((item) => item.id == cartItemId);
  if (index != -1) {
    cartItems[index].quantity = (cartItems[index].quantity ?? 1) + 1;
    cartItems[index].price = (cartItems[index].quantity ?? 0) * (cartItems[index].piecePrice ?? 0);
    totalCartPrice += cartItems[index].piecePrice ?? 0;
     await updateCartItemQuantity(
      cartItemId: cartItemId,
      quantity: cartItems[index].quantity ?? 1,
       price: cartItems[index].price ?? 0,
    );
  }
}
void decreaseCartItemQuantity({required String cartItemId}) async{
  var index = cartItems.indexWhere((item) => item.id == cartItemId);
  if (index != -1 && (cartItems[index].quantity ?? 1) > 1) {
    cartItems[index].quantity = (cartItems[index].quantity ?? 1) - 1;
    cartItems[index].price = (cartItems[index].quantity ?? 0) * (cartItems[index].piecePrice ?? 0);
    totalCartPrice -= cartItems[index].piecePrice ?? 0;
    await updateCartItemQuantity(
      cartItemId: cartItemId,
      quantity: cartItems[index].quantity ?? 1,
      price: cartItems[index].price ?? 0,
    );
  }
}

Future<void> updateCartItemQuantity({required String cartItemId, required int quantity,required int price}) async {
  emit(UpdateCartItemQuantityLoadingState());
    try {
      var response = await DioHelper.patch(endPoint: EndPoints.cart,
      queryParameters: {
        'id':"eq.$cartItemId"
      },
      body: {
        'quantity': quantity,
        'price': price,
      });
      emit(UpdateCartItemQuantitySuccessState());
    } catch (e) {
      log('Error updating cart item quantity: $e');
      getCartItems();
      emit(UpdateCartItemQuantityErrorState());
    }
  }



///Paymob related methods can be added here

  final Dio _dio = Dio();
  bool isCardPayment = true; // Default payment method
  bool isSuccessTransaction = false; // Track payment success

   int? superOrderId;
   String?  superAuthToken;
  // Step 1: Get Auth Token
  Future<String> getAuthToken() async {
    final String authToken;
    emit(GetAuthTokenLoadingState());
    try{
      final authRes = await _dio.post(
        "https://accept.paymob.com/api/auth/tokens",
        data: {"api_key": apikeyPaymob},
      );
       authToken = authRes.data["token"];
      emit(GetAuthTokenSuccessState());
    }catch(e) {
      emit(GetAuthTokenErrorState());
      rethrow;
    }
    return authToken;
  }
  // Step 2: Create Order
  Future<dynamic> createOrder(String authToken, int amountInCents, String currency) async{
    final dynamic orderId;
    emit(CreateOrderLoadingState());
    try{
      final orderRes = await _dio.post(
        "https://accept.paymob.com/api/ecommerce/orders",
        data: {
          "auth_token": authToken,
          "delivery_needed": "false",
          "amount_cents": amountInCents.toString(),
          "currency": currency,
          "items": [],
        },
      );
       orderId = orderRes.data["id"];
      emit(CreateOrderSuccessState());
    }catch(e) {
      emit(CreateOrderErrorState());
      rethrow;
    }
    return orderId;
  }
  // Step 3: Get Payment Key
  Future<String> getPaymentKey(String authToken, dynamic orderId, int amountInCents, String currency) async {
    final String paymentToken;
    emit(GetPaymentKeyLoadingState());
    try {
      final paymentKeyRes = await _dio.post(
        "https://accept.paymob.com/api/acceptance/payment_keys",
        data: {
          "auth_token": authToken,
          "amount_cents": amountInCents.toString(),
          "expiration": 3600,
          "order_id": orderId,
          "billing_data": {
            "apartment": "NA",
            "email": client?.email ?? "NA",
            "floor": "NA",
            "first_name": "NA",
            "street": "NA",
            "building": "NA",
            "phone_number": "+201000000000",
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "Cairo",
            "country": "EG",
            "last_name": "Doe",
            "state": "NA"
          },
          "currency": currency,
          "integration_id": isCardPayment?integrationCardId:integrationMobileWalletId, // Use card or wallet integration ID
        },
      );
       paymentToken = paymentKeyRes.data["token"];
      emit(GetPaymentKeySuccessState());
    }catch(e){
      emit(GetPaymentKeyErrorState());
      rethrow;
    }
    return paymentToken;
  }
  //step 4: Pay with Card
  Future<void> payWithCard(int amountInPound, String currency) async {
    isSuccessTransaction = false; // Set transaction failure status
   isCardPayment = true; // Set payment method to card
    int amountInCents = amountInPound * 100; // Convert to cents
    final authToken = await getAuthToken(); // step 1
    final orderId = await createOrder(authToken, amountInCents,currency); // step 2
    final paymentToken = await getPaymentKey(authToken, orderId, amountInCents,currency); // step 3
   superOrderId = orderId; // Store order ID for later use
    superAuthToken = authToken; // Store auth token for later use
    emit(PaymentLoadingState());
    try {
      // Step 4: Open Paymob Iframe
      final iframeUrl =
          "https://accept.paymob.com/api/acceptance/iframes/$iframeId?payment_token=$paymentToken";
      if (await canLaunchUrl(Uri.parse(iframeUrl))) {
        await launchUrl(Uri.parse(iframeUrl),
            mode: LaunchMode.externalApplication);
        // Add order to DB after payment
        await waitForPaymentCheckStatus();
        await addOrderToDB(paymobOrderID: orderId);
        emit(PaymentSuccessState());
      } else {
        isSuccessTransaction = false; // Set transaction failure status
        emit(PaymentErrorState());
        print("Paymob error: Unable to launch URL");
      }
    } catch (e) {
      print("Paymob error: $e");
      isSuccessTransaction = false; // Set transaction failure status
      emit(PaymentErrorState());
    }

  }

  //step 4: Pay with Wallet
  Future<void> payWithWallet(String walletNumber, int amountInPounds,String currency) async {
    isCardPayment = false; // Set to false for wallet payment
    int amountInCents = amountInPounds * 100; // Convert to cents
    final authToken = await getAuthToken(); // step 1
    final orderId = await createOrder(authToken, amountInCents,currency); // step 2
    final paymentToken = await getPaymentKey(authToken, orderId, amountInCents,currency); // step 3
    superOrderId = orderId; // Store order ID for later use
    superAuthToken = authToken; // Store auth token for later use
    emit(PaymentLoadingState());
    try{
      final walletRes = await _dio.post(
        "https://accept.paymob.com/api/acceptance/payments/pay",
        data: {
          "source": {
            "identifier": walletNumber,
            "subtype": "WALLET"
          },
          "payment_token": paymentToken
        },
      );

      final redirectUrl = walletRes.data["redirect_url"];
      if (await canLaunchUrl(Uri.parse(redirectUrl))) {
        await launchUrl(Uri.parse(redirectUrl), mode: LaunchMode.externalApplication);
      }
      await waitForPaymentCheckStatus();
      await  addOrderToDB(paymobOrderID: orderId);
      emit(PaymentSuccessState());
    }catch(e){
      isSuccessTransaction = false; // Set transaction failure status
      emit(PaymentErrorState());
      print("Paymob error: $e");
    }
  }

  Future<void> payWithCashOnDelivery() async {
    emit(PaymentLoadingState());
    try{
      await addOrderToDB();
      isSuccessTransaction = true; // Set transaction success status
      emit(PaymentSuccessState());
    }catch(e){
      isSuccessTransaction = false; // Set transaction failure status
      emit(PaymentErrorState());
      rethrow;
    }

  }

  Future<void> waitForPaymentCheckStatus() async {
    final dio = Dio();
    isSuccessTransaction = false; // Set transaction failure status
    await Future.delayed(Duration(seconds: 70)); //
    emit(CheckPaymentLoadingStatusState());
    try {
      // 1️⃣ Get transactions for the order
      final res = await dio.get(
        "https://accept.paymob.com/api/acceptance/transactions",
        queryParameters: {
          "order": superOrderId,
          "token": superAuthToken,
        },
      );
      print("TT ${res.data}");
      if (res.data["results"] is List && res.data["results"].isNotEmpty) {
        // Get the latest transaction
        final latestTransaction = res.data["results"].first;
        //final transactionId = latestTransaction["id"];
        final lastOrderId = latestTransaction["order"]["id"];
        bool success = false;
        if(lastOrderId == superOrderId) {
          success = latestTransaction["success"] == true;
        }
        print("Tr ID:${latestTransaction["id"]}---- Order ID: $superOrderId --- loid $lastOrderId- Success: $success");
        if (success) {
          isSuccessTransaction = true; // Set transaction success status

          emit(CheckPaymentSuccessStatusState());
        } else if (latestTransaction["pending"] == false) {
          isSuccessTransaction = false; // Set transaction success status
          emit(CheckPaymentErrorStatusState());
        }
      }
    } catch (e) {
      isSuccessTransaction = false; // Set transaction success status
      emit(CheckPaymentErrorStatusState());
      print("Error checking payment: $e");
    }

  }


  ///Order related methods can be added here in supabase
  GlobalKey<FormState> orderFormKey = GlobalKey<FormState>();
TextEditingController orderFullNameController = TextEditingController();
 TextEditingController orderPhoneController = TextEditingController();
 TextEditingController orderAddressController = TextEditingController();
  TextEditingController orderCityController = TextEditingController();

  FocusNode orderFullNameFocusNode = FocusNode();
  FocusNode orderPhoneFocusNode = FocusNode();
  FocusNode orderAddressFocusNode = FocusNode();
  FocusNode orderCityFocusNode = FocusNode();

  OrderShippingMethod orderShippingMethod = OrderShippingMethod.standard; // Default shipping method
  String shippingMethod = 'Standard'; // Default shipping method

  int shippingStandardPrice = 50; // Default shipping price
  int shippingExpressPrice = 100; // Express shipping price
  int shippingFeesPrice = 0; // Shipping fees price
  void changeShippingMethod(String value) {
    if(value == 'Standard') {
      orderShippingMethod = OrderShippingMethod.standard;
      shippingFeesPrice = shippingStandardPrice; // Set standard shipping price
    } else if(value == 'Express') {
      orderShippingMethod = OrderShippingMethod.express;
      shippingFeesPrice = shippingExpressPrice; // Set express shipping price
    }
    shippingMethod = value;
  emit(ChangeShippingMethodState());
  }
  String? validator(String?  value){
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }



  OrderPaymentMethod orderPaymentMethod = OrderPaymentMethod.card; // Default payment method
  String paymentMethod = 'Card'; // Default payment method
  void changeOrderPaymentMethod(OrderPaymentMethod method) {
    if(method == OrderPaymentMethod.card) {
      orderPaymentMethod = OrderPaymentMethod.card;
      paymentMethod = 'Card'; // Set to card payment
    } else if(method == OrderPaymentMethod.wallet) {
      orderPaymentMethod = OrderPaymentMethod.wallet;
      paymentMethod = 'Wallet'; // Set to wallet payment
    } else if(method == OrderPaymentMethod.cashOnDelivery) {
      orderPaymentMethod = OrderPaymentMethod.cashOnDelivery;
      paymentMethod = 'Cash on Delivery'; // Set to cash on delivery
    }
    emit(ChangePaymentMethodState());
  }

  int orderTotalPrice = 0; // Total price of items in the cart
  int getOrderTotalPrice() {
    orderTotalPrice = totalCartPrice + shippingFeesPrice; // Calculate total price including shipping fees
    return orderTotalPrice;
  }


  // Create Order in Supabase
Future<void> addOrderToDB({paymobOrderID})async{
    emit(AddOrderLoadingState());
    try{
      await DioHelper.post(endPoint: EndPoints.orders,
      body:{
        "user_id": client?.id,
        "payment_method": paymentMethod,
        "paymob_order_id": paymobOrderID,
        "shipping_method": shippingMethod,
        "subtotal": totalCartPrice,
        "shipping_fees": shippingFeesPrice,
        "total": orderTotalPrice,
        "status": "pending",
        "full_name": orderFullNameController.text,
        "email": client?.email,
        "phone": orderPhoneController.text,
        "city": orderCityController.text,
        "address": orderAddressController.text
      });
      await addOrderItemsToDB();
      await removeOrderItemsFromCart(); // Clear cart after order is placed
      emit(AddOrderSuccessState());
    }catch(e){
      log('Error adding order to DB: $e');
      emit(AddOrderErrorState());
      rethrow;
    }
}

//Get OrderId From Supabase
  Future<String?> getOrderIdFromDB() async {
    emit(GetOrderIdLoadingState());
    String? orderId;
    try{
      var response = await DioHelper.get(endPoint: EndPoints.orders,
      queryParameters: {
        'user_id':"eq.${client?.id}"
      });
      orderId = response.data.isNotEmpty ? response.data.last['id'] : null; // Get the last order ID
      return orderId;
    }catch(e){
      log('Error getting order ID from DB: $e');
      emit(GetOrderIdErrorState());
      return null;
    }

  }
  void clearOrderForm() {
    orderFullNameController.clear();
    orderPhoneController.clear();
    orderAddressController.clear();
    orderCityController.clear();
    orderShippingMethod = OrderShippingMethod.standard; // Reset to default shipping method
    shippingMethod = 'Standard'; // Reset to default shipping method
    shippingFeesPrice = shippingStandardPrice; // Reset to default shipping price
    orderPaymentMethod = OrderPaymentMethod.card; // Reset to default payment method
    paymentMethod = 'Card'; // Reset to default payment method
    orderTotalPrice = 0; // Reset total price
  }

  //Add Order Item to Supabase
Future<void> addOrderItemsToDB() async{
  String? orderId = await getOrderIdFromDB();
  if(orderId == null) {
    log('No order ID found in DB');
    return;
  }
    emit(AddOrderItemLoadingState());
    try{
     for(int i=0;i<cartItems.length;i++){
       await DioHelper.post(endPoint: EndPoints.orderItems,
           body: {
              "order_id": orderId,
              "user_id": client?.id,
              "product_id": cartItems[i].productId,
              "name": cartItems[i].name,
              "img_url": cartItems[i].imageUrl,
              "quantity": cartItems[i].quantity,
              "price": cartItems[i].price,
              "size": cartItems[i].size,
              "color": cartItems[i].color,
              "piece_price": cartItems[i].piecePrice
           });
     }
      emit(AddOrderItemSuccessState());
    }catch(e){
      log('Error adding order item to DB: $e');
      emit(AddOrderItemErrorState());
      rethrow;
    }
}

//Remove Order Items From Cart
Future<void> removeOrderItemsFromCart() async {
  cartItems.clear();
  totalCartPrice = 0;
  emit(RemoveOrderItemLoadingState());
  try {
    var response = await DioHelper.delete(endPoint: EndPoints.cart,
      queryParameters: {
        'user_id':"eq.${client?.id}"
      });
    emit(RemoveOrderItemSuccessState());
  } catch (e) {
    log('Error removing order items from cart: $e');
    emit(RemoveOrderItemErrorState());
  }
}
}