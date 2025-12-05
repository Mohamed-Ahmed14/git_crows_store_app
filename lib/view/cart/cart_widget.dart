import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothing_store/model/cart_model/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/cubit/order_cubit/order_cubit.dart';
import '../../view_model/utilities/colors.dart';

class CartWidget extends StatelessWidget {
  final CartItemModel cartItem;
  const CartWidget({super.key, required this.cartItem});

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
              padding: EdgeInsetsDirectional.all(30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(cartItem.name ?? "",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.black
                      ),),
                      SizedBox(
                        height: 40.h,
                        child: IconButton(
                            padding: EdgeInsetsDirectional.zero,
                            onPressed: (){
                              ///Remove item from cart
                               OrderCubit.get(context).removeFromCart( cartItemId: cartItem.id!);
                            },
                            icon: Icon(Icons.delete_rounded,color: AppColors.red,size: 60.w,)),
                      )
                    ],
                  ),
                  Text('${cartItem.price} LE',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black
                  ),),
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Size:${cartItem.size} | Color:${cartItem.color}',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.grey,
                          fontSize: 30.sp,
                        ),),
                      ),
                      Container(
                        height: 80.h,
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                              color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width:50.w,
                              child: IconButton(
                                  padding: EdgeInsetsDirectional.zero,
                                  onPressed:(){
                                    OrderCubit.get(context).decreaseCartItemQuantity(cartItemId: cartItem.id!);
                                  },
                                  icon: Icon(Icons.remove_rounded,size: 60.r,
                                   color:  Theme.of(context).secondaryHeaderColor,)),
                            ),
                            SizedBox(width: 20.w,),
                            Text("${cartItem.quantity ?? 1}",style: Theme.of(context).textTheme.bodyMedium,),
                            SizedBox(width: 20.w,),
                            SizedBox(
                              width: 50.w,
                              child: IconButton(
                                  padding: EdgeInsetsDirectional.zero,
                                  onPressed:(){
                                    OrderCubit.get(context).increaseCartItemQuantity(cartItemId: cartItem.id!);
                                  },
                                  icon: Icon(Icons.add,size: 60.r,
                                    color:  Theme.of(context).secondaryHeaderColor,)),
                            ),
                          ],
                        ),
                      ),
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
