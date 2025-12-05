import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothing_store/model/cart_model/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/utilities/colors.dart';

class OrderItemsWidget extends StatelessWidget {
  final CartItemModel cartItem;
  const OrderItemsWidget({required this.cartItem,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color:AppColors.lightGrey,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: cartItem.imageUrl ?? '',
            height: 300.h,
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error,color: AppColors.red),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.name ?? "",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black
                  ),),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quantity:${cartItem.quantity}',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.black
                      ),),
                      Text('${cartItem.price} LE',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.black
                      ),),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Color:${cartItem.color}',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.black
                      ),),
                      Text('Size:${cartItem.size}',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.black
                      ),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
