import 'dart:developer';

import 'package:clothing_store/model/home_model/basic_category_model.dart';
import 'package:clothing_store/model/product_model/product_color_model.dart';
import 'package:clothing_store/model/product_model/product_details_model.dart';
import 'package:clothing_store/model/product_model/product_size_model.dart';
import 'package:clothing_store/view_model/data/network/dio_helper.dart';
import 'package:clothing_store/view_model/data/network/end_points.dart';
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../model/product_model/product_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  var client = Supabase.instance.client;
  ///Basic Category List

  List<BasicCategoryModel> basicCategoryList = [
    BasicCategoryModel(
        icon: Icons.female_rounded, category: 'Women', isSelected: true),
    BasicCategoryModel(
        icon: Icons.male_rounded, category: 'Men', isSelected: false),
    BasicCategoryModel(icon: Icons.face, category: 'Children', isSelected: false),
    BasicCategoryModel(
        icon: Icons.watch_rounded, category: 'Accessories', isSelected: false),
  ];

//Test List for Product
  List<ProductModel> products = [];

//Functions for popular products and recommend sections
  List<ProductModel> popularProductsList = [];
  List<ProductModel> recommendedList = [];

  void getPopularProducts() {
    popularProductsList.clear();
    emit(GetPopularLoadingState());
    for (int i = 0; i < products.length; i++) {
      popularProductsList = products
          .where(
            (element) => element.isPopular == true,
          )
          .toList();
    }
    emit(GetPopularSuccessState());
  }

  void getRecommendedProducts() {
    emit(GetRecommendedLoadingState());
    recommendedList.clear();
    for (int i = 0; i < products.length; i++) {
      recommendedList = products
          .where(
            (element) => element.isRecommended == true,
          )
          .toList();
    }
    emit(GetRecommendedSuccessState());
  }

  Future<void> getAllProducts() async{
    products.clear();
    emit(GetAllProductLoadingState());
    try{
      Response response = await DioHelper.get(
          endPoint: EndPoints.products,);
      for(var i in response.data){
        products.add(ProductModel.fromJson(i));
      }
      getPopularProducts();
      getRecommendedProducts();
      emit(GetAllProductSuccessState());
    }catch(e){
      log(e.toString());
      emit(GetAllProductErrorState());
    }

  }

  ProductDetailsModel? productDetailsModel;
  List<ProductColorModel> productColors = [
    ProductColorModel(
      colorName: 'Grey',
      colorValue: AppColors.grey,
      isSelected: true, // Default selected color
    ),
    ProductColorModel(
        colorName: 'Red',
        colorValue: AppColors.red,
    ),
    ProductColorModel(
        colorName: 'Blue',
        colorValue: AppColors.blue,
    ),
  ];
  List<ProductSizeModel> productSizes = [
    ProductSizeModel(
      sizeName: 'S',
    ),
    ProductSizeModel(
      sizeName: 'M',
      isSelected: true, // Default selected size
    ),
    ProductSizeModel(
      sizeName: 'L',
    ),

  ];
  String selectedSize = 'M';
  String selectedColor = 'Grey';
  Future<void> showProductDetails({required String productId}) async{
    productDetailsModel = null;
    emit(ShowProductDetailsLoadingState());
    try{
      Response response = await DioHelper.get(
          endPoint: EndPoints.products,
      queryParameters: {
            "select" : "*,favorites(*)",
        "id" : "eq.$productId",
        "favorites.user_id":"eq.${client.auth.currentUser!.id}",
      });
      productDetailsModel = ProductDetailsModel.fromJson(response.data[0]);
      isFavorite();
      //Default selected size and color
      selectedSize = 'M';
      selectedColor = 'Grey';
      changeSelectedColor(0);
      changeSelectedSize(1);
      emit(ShowProductDetailsSuccessState());
    }catch(e){
      log(e.toString());
      emit(ShowProductDetailsErrorState());
    }
  }

  void changeSelectedSize(index) {
    selectedSize = productSizes[index].sizeName;
    for(var element in productSizes) {
      element.isSelected = false;
    }
    productSizes[index].isSelected = true;
    emit(ChangeSelectedSizeState());
  }
  void changeSelectedColor(index) {
    selectedColor = productColors[index].colorName;
    for(var element in productColors) {
      element.isSelected = false;
    }
    productColors[index].isSelected = true;

    emit(ChangeSelectedColorState());
  }

  bool isFavoriteProduct = false;
  void isFavorite(){
    isFavoriteProduct = false;
    if(productDetailsModel != null){
      if(productDetailsModel!.favorites!.isNotEmpty){
        isFavoriteProduct= true;
      }
    }
  }
}
