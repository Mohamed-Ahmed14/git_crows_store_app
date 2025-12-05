import 'package:clothing_store/view/layout/layout_screen.dart';
import 'package:clothing_store/view/widgets/custom_progress_indicator.dart';
import 'package:clothing_store/view_model/cubit/layout_cubit/layout_cubit.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_cubit.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/order_model/order_enum.dart';
import 'checkout_steps_widget.dart';

class PaymentStatusScreen extends StatefulWidget {
  const PaymentStatusScreen({super.key});

  @override
  State<PaymentStatusScreen> createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {

  @override
  void initState() {
    print("Hi There");
    // TODO: implement initState
    // if(OrderCubit.get(context).orderPaymentMethod == OrderPaymentMethod.card){
    //   OrderCubit.get(context).waitForPaymentCardStates();
    // }else if(OrderCubit.get(context).orderPaymentMethod == OrderPaymentMethod.wallet){
    //   OrderCubit.get(context).waitForPaymentWalletStatus("01010101010");
    // }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded,color: Theme.of(context).secondaryHeaderColor,),
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LayoutScreen(),),
                  (route) => false,);
          },
        ),
      ),
      ///This screen need refactor to handle status of transaction is success or not
      body: BlocBuilder<OrderCubit,OrderState>(builder: (context, state) {
        var cubit = OrderCubit.get(context);
        if(state is CheckPaymentSuccessStatusState || cubit.orderPaymentMethod == OrderPaymentMethod.cashOnDelivery ||
        cubit.isSuccessTransaction == true) {
          return ListView(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 40.w),
            children: [
              CheckoutStepsWidget(stepNum: 3,),
              SizedBox(
                height: 100.h,
              ),
              Image.asset('assets/images/order_images/order_successful.png'),
              Text(
                'Order successful!',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                'Your have successfully made order!',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(

                  ),
                  onPressed: () {
                    LayoutCubit.get(context).setNewIndex(0);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LayoutScreen(),),
                          (route) => false,);
                  },
                  child: Text('Continue Shopping'),
                ),
              ),
            ],
          );
        }
        else if(state is PaymentErrorState || state is CheckPaymentErrorStatusState
            || (cubit.isSuccessTransaction == false && state is PaymentSuccessState)) {
          return Center(child: Text(
            'Something went wrong, please try later.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ));
        }
        else{
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomProgressIndicator(),
              SizedBox(height: 20.h,),
              Text(
                'Loading, Please wait...',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ));
        }
      },),
    );
  }
}
