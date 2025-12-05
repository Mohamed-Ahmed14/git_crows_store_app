import 'package:clothing_store/view/cart/order_items_widget.dart';
import 'package:clothing_store/view/widgets/custom_progress_indicator.dart';
import 'package:clothing_store/view_model/cubit/profile_cubit/profile_cubit.dart';
import 'package:clothing_store/view_model/cubit/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../model/order_model/orders_model.dart';
import '../../../view_model/utilities/colors.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrdersModel ordersModel;
  final int index;
  const OrderDetailsScreen({required this.index,required this.ordersModel,super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    ProfileCubit.get(context).getOrderDetails(widget.ordersModel.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body:BlocConsumer<ProfileCubit,ProfileState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          if (state is GetOrderDetailsLoadingState) {
            return const Center(child: CustomProgressIndicator());
          }else if(state is GetOrderDetailsErrorState){
            return Center(
              child: Text(
                'No order details available,\nPlease try again later.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            );
          }else{
            return Padding(
              padding:  EdgeInsetsDirectional.all(20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.all(40.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.shadowGrey,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order Number',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),
                          SizedBox(height: 20.h,),
                          Text('#${widget.index+1}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.black
                            ),),
                          SizedBox(height: 20.h,),
                          Text('Order Id',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),
                          SizedBox(height: 20.h,),
                          Text('${widget.ordersModel.id}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 40.sp,
                                  color: AppColors.black
                              )),
                          SizedBox(height: 20.h,),
                          Text('Order Date',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),
                          SizedBox(height: 20.h,),
                          Text(DateFormat('dd/MM/yyyy').format(
                              DateTime.parse(widget.ordersModel.createdAt!)),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.black
                              )),
                          SizedBox(height: 20.h,),
                          Text('Order Status',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),
                          SizedBox(height: 20.h,),
                          Text('${widget.ordersModel.status}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.indigo
                            ),),
                          SizedBox(height: 20.h,),
                          Text('Payment Method',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),
                          SizedBox(height: 20.h,),
                          Text('${widget.ordersModel.paymentMethod}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.black
                              )),
                          SizedBox(height: 20.h,),
                          Text('shipping address',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),
                          SizedBox(height: 20.h,),
                          Text('${widget.ordersModel.address}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.black
                              )),
                          SizedBox(height: 20.h,),
                          Text('shipping method',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),
                          SizedBox(height: 20.h,),
                          Text('${widget.ordersModel.shippingMethod}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.black
                              )),
                          SizedBox(height: 20.h,),
                          Text('shipping fee',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),
                          SizedBox(height: 20.h,),
                          Text('${widget.ordersModel.shippingFees} EGP',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.black
                              )),
                          SizedBox(height: 20.h,),
                          Text('Subtotal',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),
                          SizedBox(height: 20.h,),
                          Text('${widget.ordersModel.subtotal} EGP',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.black
                              )),
                          SizedBox(height: 20.h,),
                          Text('Total Amount',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),
                          SizedBox(height: 20.h,),
                          Text('${widget.ordersModel.total} EGP',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.red
                            ),),
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColors.shadowGrey,
                      thickness: 2,
                    ),
                    Text('Order Items',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: 20.h,),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return OrderItemsWidget(cartItem: cubit.orderItemsList[index],);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20.h,);
                        },
                        itemCount: cubit.orderItemsList.length),
                  ],
                ),
              ),
            );
          }
          }


      )
    );
  }
}
