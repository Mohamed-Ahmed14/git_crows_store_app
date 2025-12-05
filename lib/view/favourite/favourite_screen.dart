import 'package:clothing_store/view/favourite/favourite_widget.dart';
import 'package:clothing_store/view/widgets/custom_progress_indicator.dart';
import 'package:clothing_store/view_model/cubit/favorite_cubit/favorite_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/cubit/favorite_cubit/favorite_cubit.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  @override
  void initState() {
    // TODO: implement initState
    FavoriteCubit.get(context).getFavoriteProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        title: Text('My Wishlist',style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: 60.sp,
          fontWeight: FontWeight.w700
        ),),
      ),
      body: BlocConsumer<FavoriteCubit,FavoriteState>(
        listener: (context, state) {

        },builder: (context, state) {
          return (state is GetFavoriteProductsLoadingState || state is RemoveFavoriteProductsLoadingState)?
              CustomProgressIndicator():FavoriteCubit.get(context).favouriteList.isEmpty?
          Center(child: Text('Your wishlist is empty')):GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: 0.6,crossAxisSpacing: 60.w,mainAxisSpacing: 30.h),
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsetsDirectional.only(top:30.h,start: 60.w,end: 60.w,bottom: MediaQuery.of(context).padding.bottom),
            itemBuilder: (context, index) {
              return FavouriteWidget(productModel: FavoriteCubit.get(context).favouriteList[index]);
            },
            itemCount:  FavoriteCubit.get(context).favouriteList.length,
          );
        },
      ),
    );
  }
}
