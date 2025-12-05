import 'dart:developer';

import 'package:clothing_store/view_model/data/network/dio_helper.dart';
import 'package:clothing_store/view_model/data/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../model/product_model/product_model.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState>{
  FavoriteCubit():super(FavoriteInitState());

  static FavoriteCubit get(context)=>BlocProvider.of<FavoriteCubit>(context);

  var client = Supabase.instance.client;
  //Test List for Favourites
  List<ProductModel> favouriteList = [];

  Future<void> getFavoriteProducts() async{
    favouriteList.clear();
    emit(GetFavoriteProductsLoadingState());

    try{
      Response response = await DioHelper.get(
          endPoint: EndPoints.favorites,
      queryParameters: {
            "select": "*,products(*)",
        "user_id": "eq.${client.auth.currentUser?.id}"
      });
      for(var i in response.data){
        favouriteList.add(ProductModel.fromJson(i["products"]));
      }
      emit(GetFavoriteProductsSuccessState());
    }catch(e){
      log(e.toString());
      emit(GetFavoriteProductsErrorState());
    }

  }

  void toggleFavorite({required isFavorite,required String productId}){
    if(isFavorite){
      removeProductToFavorites(productId: productId);
    }else{
      addProductToFavorites(productId: productId);
    }
  }

  Future<void> addProductToFavorites({required String productId})async{
    emit(AddFavoriteProductsLoadingState());
    try{
       await DioHelper.post(
          endPoint: EndPoints.favorites,
      body: {
        "is_favorite": true,
        "user_id": client.auth.currentUser?.id,
        "product_id": productId
      });
      getFavoriteProducts();
      emit(AddFavoriteProductsSuccessState());
    }catch(e){
      log(e.toString());
      emit(AddFavoriteProductsErrorState());
    }
  }

  Future<void> removeProductToFavorites({required String productId})async{
    emit(RemoveFavoriteProductsLoadingState());
    try{
      await DioHelper.delete(
          endPoint: EndPoints.favorites,
         queryParameters: {
            "user_id":"eq.${client.auth.currentUser?.id}",
           "product_id":"eq.$productId"
         });
      getFavoriteProducts();
      emit(RemoveFavoriteProductsSuccessState());
    }catch(e){
      log(e.toString());
      emit(RemoveFavoriteProductsErrorState());
    }
  }

}