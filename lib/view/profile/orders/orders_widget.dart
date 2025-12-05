import 'package:clothing_store/model/order_model/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../view_model/utilities/colors.dart';
import 'order_details_screen.dart';

class OrdersWidget extends StatelessWidget {
  final OrdersModel ordersModel;
  final int index;
  const OrdersWidget({required this.ordersModel,required this.index,super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailsScreen(index: index,ordersModel: ordersModel,),));
      },
      child: Container(
        padding: EdgeInsetsDirectional.all(40.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.shadowGrey,
          ),),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order #${index+1}',
                    style: Theme.of(context).textTheme.bodyLarge,),
                  Text(DateFormat('dd/MM/yyyy').format(
                      DateTime.parse(ordersModel.createdAt!)),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey
                    ),),
                ]
            ),
            SizedBox(height: 20.h,),
            Text('Order ID: ${ordersModel.id}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 40.sp,
                  color: AppColors.grey
              ),
            overflow: TextOverflow.ellipsis,),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${ordersModel.status}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.indigo
                  ),),
                Text('${ordersModel.total} EGP',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.red
                  ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
