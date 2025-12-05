abstract class OrderState {}

class OrderInitState extends OrderState {}

class GetCartItemsLoadingState extends OrderState {}
class GetCartItemsSuccessState extends OrderState {}
class GetCartItemsErrorState extends OrderState {}

class AddToCartLoadingState extends OrderState {}
class AddToCartSuccessState extends OrderState {}
class AddToCartErrorState extends OrderState {}

class RemoveFromCartLoadingState extends OrderState {}
class RemoveFromCartSuccessState extends OrderState {}
class RemoveFromCartErrorState extends OrderState {}

class UpdateCartItemQuantityLoadingState extends OrderState {}
class UpdateCartItemQuantitySuccessState extends OrderState {}
class UpdateCartItemQuantityErrorState extends OrderState {}

class GetAuthTokenLoadingState extends OrderState {}
class GetAuthTokenSuccessState extends OrderState {}
class GetAuthTokenErrorState extends OrderState {}


class CreateOrderLoadingState extends OrderState {}
class CreateOrderSuccessState extends OrderState {}
class CreateOrderErrorState extends OrderState {}

class GetPaymentKeyLoadingState extends OrderState {}
class GetPaymentKeySuccessState extends OrderState {}
class GetPaymentKeyErrorState extends OrderState {}

class PaymentLoadingState extends OrderState {}
class PaymentSuccessState extends OrderState {}
class PaymentErrorState extends OrderState {}

class CheckPaymentLoadingStatusState extends OrderState {}
class CheckPaymentSuccessStatusState extends OrderState {}
class CheckPaymentErrorStatusState extends OrderState {}


class ChangeShippingMethodState extends OrderState {}
class ChangePaymentMethodState extends OrderState {}

///Supabase Order States
class AddOrderLoadingState extends OrderState {}
class AddOrderSuccessState extends OrderState {}
class AddOrderErrorState extends OrderState {}

class GetOrderIdLoadingState extends OrderState {}
class GetOrderIdSuccessState extends OrderState {}
class GetOrderIdErrorState extends OrderState {}

//Order Items states
class AddOrderItemLoadingState extends OrderState {}
class AddOrderItemSuccessState extends OrderState {}
class AddOrderItemErrorState extends OrderState {}

//Remove Order Item states
class RemoveOrderItemLoadingState extends OrderState {}
class RemoveOrderItemSuccessState extends OrderState {}
class RemoveOrderItemErrorState extends OrderState {}