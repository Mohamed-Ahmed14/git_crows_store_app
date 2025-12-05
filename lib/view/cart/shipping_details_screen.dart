import 'package:clothing_store/view/cart/payment_details_screen.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_cubit.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_state.dart';
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'checkout_steps_widget.dart';

class ShippingDetailsScreen extends StatefulWidget {
  const ShippingDetailsScreen({super.key});

  @override
  State<ShippingDetailsScreen> createState() => _ShippingDetailsScreenState();
}

class _ShippingDetailsScreenState extends State<ShippingDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    OrderCubit.get(context).clearOrderForm();
    super.initState();
  }
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
        },
        builder: (context, state) {
          var cubit = OrderCubit.get(context);
          return ListView(
            padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
            children: [
              SizedBox(
                height: 20.h,
              ),
              CheckoutStepsWidget(stepNum: 1,),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'STEP 1',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.grey),
              ),
              Text('Shipping Details',
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(
                height: 20.h,
              ),
              Form(
                key: cubit.orderFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Full Name Field
                    TextFormField(
                      controller: cubit.orderFullNameController,
                      validator: cubit.validator,
                      focusNode: cubit.orderFullNameFocusNode,
                      onTapOutside: (value){
                        cubit.orderFullNameFocusNode.unfocus();
                      },
                      cursorColor: Theme.of(context).secondaryHeaderColor,
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                        label: Text(
                          'Full Name *',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),

                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                        errorBorder: UnderlineInputBorder(),
                        contentPadding: EdgeInsetsDirectional.symmetric(
                            vertical: 20.h, horizontal: 10.w),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    ///Phone Field
                    TextFormField(
                      controller: cubit.orderPhoneController,
                      validator: cubit.validator,
                      focusNode: cubit.orderPhoneFocusNode,
                      onTapOutside: (value){
                        cubit.orderPhoneFocusNode.unfocus();
                      },
                      cursorColor: Theme.of(context).secondaryHeaderColor,
                      style: Theme.of(context).textTheme.bodySmall,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          'Phone *',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                        errorBorder: UnderlineInputBorder(),
                        contentPadding: EdgeInsetsDirectional.symmetric(
                            vertical: 20.h, horizontal: 10.w),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    ///City Field
                    TextFormField(
                      controller: cubit.orderCityController,
                      validator: cubit.validator,
                      focusNode: cubit.orderCityFocusNode,
                      onTapOutside: (value){
                        cubit.orderCityFocusNode.unfocus();
                      },
                      style: Theme.of(context).textTheme.bodySmall,
                      cursorColor: Theme.of(context).secondaryHeaderColor,
                      decoration: InputDecoration(
                        label: Text(
                          'City *',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                        errorBorder: UnderlineInputBorder(),
                        contentPadding: EdgeInsetsDirectional.symmetric(
                            vertical: 20.h, horizontal: 10.w),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    ///Address Field
                    TextFormField(
                      controller: cubit.orderAddressController,
                      validator: cubit.validator,
                      focusNode: cubit.orderAddressFocusNode,
                      onTapOutside: (value){
                        cubit.orderAddressFocusNode.unfocus();
                      },
                      style: Theme.of(context).textTheme.bodySmall,
                      cursorColor: Theme.of(context).secondaryHeaderColor,
                      decoration: InputDecoration(
                        label: Text(
                          'Address *',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                        errorBorder: UnderlineInputBorder(),
                        contentPadding: EdgeInsetsDirectional.symmetric(
                            vertical: 20.h, horizontal: 10.w),
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Text('Shipping method & Fees',
                        style: Theme.of(context).textTheme.bodySmall),
                    SizedBox(height: 20.h,),
                    RadioListTile(
                        value: "Standard",
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${cubit.shippingStandardPrice} LE  Standard Delivery",style: Theme.of(context).textTheme.bodySmall,),
                            Text("Delivery from 5 to 7 business days",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.grey,
                              fontSize: 36.sp,
                            ),),
                          ],
                        ),
                        groupValue: cubit.shippingMethod,
                        onChanged: (value) {
                            cubit.changeShippingMethod(value!);
                            print(cubit.shippingMethod);
                        }),
                    RadioListTile(
                        value: "Express",
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${cubit.shippingExpressPrice} LE   Express Delivery",style: Theme.of(context).textTheme.bodySmall,),
                            Text("Delivery from 2 to 3 business days",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.grey,
                              fontSize: 36.sp,
                            ),),
                          ],
                        ),
                        groupValue: cubit.shippingMethod,
                        onChanged: (value) {
                           cubit.changeShippingMethod(value!);
                            print(cubit.shippingMethod);
                        }),
                  ],
                ),
              ),
              SizedBox(height: 80.h,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 20.h),
                ),
                onPressed:(){
                  if(cubit.orderFormKey.currentState!.validate()){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaymentDetailsScreen(),));
                  }

                },
                child: Text('Continue to payment',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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


