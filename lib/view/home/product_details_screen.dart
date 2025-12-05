import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothing_store/view/home/product_color_widget.dart';
import 'package:clothing_store/view/home/product_size_widget.dart';
import 'package:clothing_store/view/widgets/custom_progress_indicator.dart';
import 'package:clothing_store/view/layout/layout_screen.dart';
import 'package:clothing_store/view_model/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:clothing_store/view_model/cubit/favorite_cubit/favorite_state.dart';
import 'package:clothing_store/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:clothing_store/view_model/cubit/home_cubit/home_state.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_cubit.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/utilities/colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  const ProductDetailsScreen({required this.productId, super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    HomeCubit.get(context).showProductDetails(productId: widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          if (state is ShowProductDetailsSuccessState
          || state is ChangeSelectedColorState || state is ChangeSelectedSizeState) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    CachedNetworkImage(
                      imageUrl: cubit.productDetailsModel?.imgUrl ?? "",
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: AppColors.red,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        margin: EdgeInsetsDirectional.only(top: 40.h),
                        padding: EdgeInsetsDirectional.all(50.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50.r,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LayoutScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 50.w,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  )),
                            ),
                            BlocConsumer<FavoriteCubit,FavoriteState>(
                              listener: (context, state) {
                                if(state is AddFavoriteProductsSuccessState){
                                  cubit.isFavoriteProduct = true;
                                }else if(state is RemoveFavoriteProductsSuccessState){
                                  cubit.isFavoriteProduct = false;
                                }
                              },
                              builder: (context, state) {
                                return CircleAvatar(
                                    radius: 50.r,
                                    backgroundColor: Theme.of(context).primaryColor,
                                    child: IconButton(
                                      onPressed: () {
                                        FavoriteCubit.get(context).toggleFavorite(
                                            isFavorite: cubit.isFavoriteProduct,
                                            productId: widget.productId);

                                        // HomeCubit.get(context).showProductDetails(
                                        //     productId: widget.productId);
                                      },
                                      icon: (cubit.isFavoriteProduct)
                                          ? Icon(
                                        Icons.favorite_outlined,
                                        size: 50.w,
                                        color: AppColors.red,
                                      )
                                          : Icon(
                                        Icons.favorite_outline_outlined,
                                        size: 50.w,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  height: MediaQuery.of(context).size.height / 2,
                  padding: EdgeInsetsDirectional.only(
                      start: 40.w, end: 40.w, bottom: 20.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.r),
                        topRight: Radius.circular(45.r)),
                  ),
                  child: Stack(
                    children: [
                      ListView(
                        padding: EdgeInsetsDirectional.only(top: 40.h),
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cubit.productDetailsModel?.name ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                "${cubit.productDetailsModel?.price ?? 0} LE",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.red, decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('In Stock: ${cubit.productDetailsModel?.stock ?? 0}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),

                              Text(
                                "${cubit.productDetailsModel?.priceAfterDiscount ?? 0} LE",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.red),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            cubit.productDetailsModel?.desc ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: AppColors.grey, fontSize: 40.sp),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Category',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            cubit.productDetailsModel?.category ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: AppColors.grey, fontSize: 40.sp),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Color: ${cubit.selectedColor}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    height: 80.h,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:(context, index) {
                                          return ProductColorWidget(productColorModel: cubit.productColors[index],index: index,);
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            width: 20.w,
                                          );
                                        },
                                        itemCount: cubit.productColors.length),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Size: ${cubit.selectedSize}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    height: 80.h,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:(context, index) {
                                          return ProductSizeWidget(productSizeModel: cubit.productSizes[index],index: index,);
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            width: 20.w,
                                          );
                                        },
                                        itemCount: cubit.productSizes.length),
                                  )

                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 150.h,
                          ),
                        ],
                      ),
                      BlocConsumer<OrderCubit,OrderState>(
                        listener: (context, state) {
                          if(state is AddToCartSuccessState){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Product added to cart',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Theme.of(context).primaryColor),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Theme.of(context).secondaryHeaderColor,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          var orderCubit = OrderCubit.get(context);
                          return Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                EdgeInsetsDirectional.symmetric(vertical: 20.h),
                              ),
                              onPressed: () {
                                orderCubit.addToCart(
                                  product: cubit.productDetailsModel!,
                                color: cubit.selectedColor,
                                size: cubit.selectedSize,
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.shopping_bag_rounded,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Text(
                                    'Add To Cart',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          );
                        },

                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if(state is ShowProductDetailsLoadingState){
            return CustomProgressIndicator(
              color: Theme.of(context).secondaryHeaderColor,
            );
          }else{
            return Center(child: Text('Something went wrong,try again...',style: Theme.of(context).textTheme.bodyMedium,),);
          }
        },
      ),
    );
  }
}
