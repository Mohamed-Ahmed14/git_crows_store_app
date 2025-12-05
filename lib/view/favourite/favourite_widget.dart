import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothing_store/view_model/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/product_model/product_model.dart';
import '../../view_model/utilities/colors.dart';
import '../home/product_details_screen.dart';

class FavouriteWidget extends StatelessWidget {
  final ProductModel productModel;
  const FavouriteWidget({required this.productModel,super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(25.r),
      color: AppColors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25.r),
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductDetailsScreen(productId: productModel.id ?? ""),));
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width/2.5,
          //margin: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsetsDirectional.all(0),
                      child:CachedNetworkImage(
                        imageUrl:productModel.imgUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error,color: AppColors.red),
                      ),

                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Text(productModel.name ?? "Cloth",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 45.sp
                    ),
                    overflow:TextOverflow.ellipsis,),
                  Text('\$ ${productModel.priceAfterDiscount ?? 0}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.red,
                        fontSize: 45.sp
                    ),),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.all(20.0.w),
                child: CircleAvatar(
                  radius: 45.r,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    padding: EdgeInsetsDirectional.all(0),
                    onPressed: (){
                    FavoriteCubit.get(context).removeProductToFavorites(productId: productModel.id!);
                  },
                      icon: Icon(
                        Icons.favorite_outlined,size: 60.w,
                        color: AppColors.red ),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
