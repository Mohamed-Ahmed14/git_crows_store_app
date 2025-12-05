import 'package:clothing_store/view/cart/payment_status_screen.dart';
import 'package:clothing_store/view/widgets/custom_progress_indicator.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_cubit.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_state.dart';
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/order_model/order_enum.dart';

class PaymentWaitingScreen extends StatelessWidget {
  const PaymentWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          color: AppColors.transparent,
        ),
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<OrderCubit,OrderState>(

        listener:  (context, state) {
          if(state is CheckPaymentLoadingStatusState || OrderCubit.get(context).orderPaymentMethod == OrderPaymentMethod.cashOnDelivery){
            print("State is : $state");
            // print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
            // Navigate to the payment status screen or show success message
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PaymentStatusScreen(),),
                  (route) => false,);
          }// emits PaymentInitialState
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Please wait while we process your payment...',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },

      ),
    );
  }
}
