import 'dart:developer';

import 'package:clothing_store/coming_soon_screen.dart';
import 'package:clothing_store/model/order_model/order_enum.dart';
import 'package:clothing_store/view/cart/payment_waiting_screen.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_cubit.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/utilities/colors.dart';
import 'checkout_steps_widget.dart';
import 'order_items_widget.dart';


class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Theme.of(context).secondaryHeaderColor,
            )),
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<OrderCubit,OrderState>(
        listener: (context, state) {
              if(state is PaymentErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Something went wrong, please try again later!"),
                  duration: Duration(seconds: 1),),
                );

              }
        },
        builder: (context, state) {
          var cubit = OrderCubit.get(context);
          return ListView(
            padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
            children: [
              SizedBox(
                height: 20.h,
              ),
              CheckoutStepsWidget(stepNum: 2,),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'STEP 2',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.grey),
              ),
              Text('Payment Details',
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(
                height: 20.h,
              ),

              ///Choose Payment Method Card Or Wallet or Payment upon receipt
              Material(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.grey.withValues(alpha: 0.4),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: () {
                    // Handle Card selection
                    cubit.changeOrderPaymentMethod(OrderPaymentMethod.card);
                    print("card selected");

                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 20.h,horizontal: 10.w),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: cubit.orderPaymentMethod == OrderPaymentMethod.card
                              ? Theme.of(context).secondaryHeaderColor
                              : Theme.of(context).primaryColor,
                          radius: 40.r,
                          child: Icon(
                            Icons.check,
                            color: cubit.orderPaymentMethod == OrderPaymentMethod.card
                                ? Theme.of(context).primaryColor
                                : AppColors.transparent,
                          ),
                        ),
                        SizedBox(width: 40.w,),
                        Expanded(child: Text('Card',style: Theme.of(context).textTheme.bodySmall)),
                        Icon(Icons.credit_card_outlined,color: Theme.of(context).secondaryHeaderColor,),
                        SizedBox(width: 40.w,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.w,),
              Material(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.grey.withValues(alpha: 0.4),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: () {
                    // Handle wallet selection
                    cubit.changeOrderPaymentMethod(OrderPaymentMethod.wallet);
                    print("wallet selected");
                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 20.h,horizontal: 10.w),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: cubit.orderPaymentMethod == OrderPaymentMethod.wallet
                              ? Theme.of(context).secondaryHeaderColor
                              : Theme.of(context).primaryColor,
                          radius: 40.r,
                          child: Icon(
                            Icons.check,
                            color: cubit.orderPaymentMethod == OrderPaymentMethod.wallet
                                ? Theme.of(context).primaryColor
                                : AppColors.transparent,
                          ),
                        ),
                        SizedBox(width: 40.w,),
                        Expanded(child: Text('Wallet',style: Theme.of(context).textTheme.bodySmall)),
                        Icon(Icons.account_balance_wallet_rounded,color: Theme.of(context).secondaryHeaderColor,),
                        SizedBox(width: 40.w,),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.w,),
              Material(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.grey.withValues(alpha: 0.4),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: () {
                    // Handle cash on delivery selection
                    cubit.changeOrderPaymentMethod(OrderPaymentMethod.cashOnDelivery);
                    print("cashOnDelivery selected");

                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 20.h,horizontal: 10.w),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(

                      children: [
                        CircleAvatar(
                          backgroundColor: cubit.orderPaymentMethod == OrderPaymentMethod.cashOnDelivery
                              ? Theme.of(context).secondaryHeaderColor
                              : Theme.of(context).primaryColor,
                          radius: 40.r,
                          child: Icon(
                            Icons.check,
                            color: cubit.orderPaymentMethod == OrderPaymentMethod.cashOnDelivery
                                ? Theme.of(context).primaryColor
                                : AppColors.transparent,
                          ),
                        ),
                        SizedBox(width: 40.w,),
                        Expanded(child: Text('Cash On Delivery',style: Theme.of(context).textTheme.bodySmall)),
                        Icon(Icons.home_rounded,color: Theme.of(context).secondaryHeaderColor,),
                        SizedBox(width: 40.w,),

                      ],
                    ),
                  ),
                ),
              ),
              ///Card View or Wallet View
              SizedBox(height: 20.h,),
              Text("Order Items"),
              SizedBox(height: 20.h,),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return OrderItemsWidget(cartItem: cubit.cartItems[index],);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20.h,);
                  },
                  itemCount: cubit.cartItems.length),
              SizedBox(height: 40.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Products Price',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.grey,
                      )),
                  Text("${cubit.totalCartPrice} EGP",style: Theme.of(context).textTheme.bodySmall,)
                ],
              ),
              Divider(
                color: AppColors.shadowGrey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping Fees',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.grey,
                      )),
                  Text("${cubit.shippingFeesPrice} EGP",style: Theme.of(context).textTheme.bodySmall,)
                ],
              ),
              Divider(
                color: AppColors.shadowGrey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.grey,
                      )),
                  Text("${cubit.getOrderTotalPrice()} EGP",style: Theme.of(context).textTheme.bodySmall,)
                ],
              ),
              SizedBox(height: 80.h,),
              ///Notes: Wallet payment requires a valid phone number.
              ///Must Allow the user to enter their phone number for wallet payments.
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 20.h),
                ),
                onPressed:(){
                  if(cubit.orderPaymentMethod == OrderPaymentMethod.card){
                    //cubit.payWithCard(cubit.orderTotalPrice, "EGP");
                  }else if(cubit.orderPaymentMethod == OrderPaymentMethod.wallet){
                   // cubit.payWithWallet("01010101010", cubit.orderTotalPrice, "EGP");
                  }else if(cubit.orderPaymentMethod == OrderPaymentMethod.cashOnDelivery){
                    // Handle cash on delivery payment
                    //log("Cash on delivery selected");
                    //cubit.payWithCashOnDelivery();
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ComingSoonScreen(),));
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => PaymentWaitingScreen(),));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => PaymentView(
                  //       onPaymentSuccess: () {
                  //         // Handle payment success
                  //         log("Payment successful");
                  //       },
                  //       onPaymentError: () {
                  //         // Handle payment failure
                  //         log("Payment failed");
                  //       },
                  //       price: 100, // Required: Total price (e.g., 100 for 100 EGP)
                  //     ),
                  //   ),
                  // );
                },
                child: Text('Place My Order',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700
                ),), ),
            ],
          );
        },

      ),
    );
  }
}
