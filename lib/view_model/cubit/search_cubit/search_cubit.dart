import 'dart:developer';

import 'package:clothing_store/model/product_model/product_model.dart';
import 'package:clothing_store/model/search_model/filter_model.dart';
import 'package:clothing_store/view_model/cubit/search_cubit/search_state.dart';
import 'package:clothing_store/view_model/data/network/dio_helper.dart';
import 'package:clothing_store/view_model/data/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchCubit extends Cubit<SearchState>{

  SearchCubit():super(SearchInitState());

  static SearchCubit get(context)=> BlocProvider.of<SearchCubit>(context);


  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  List<ProductModel> searchList = [];

  ///Filter
  List<FilterCategoryModel> filterCategoryList = [
    FilterCategoryModel(
      category: 'Women',
        isSelected: false),
    FilterCategoryModel(
        category: 'Men',
        isSelected: false),
    FilterCategoryModel(
        category: 'Children',
        isSelected: false),
    FilterCategoryModel(
        category: 'Accessories',
        isSelected: false),
  ] ;
  double endPrice = 1000.0;
  Map<String,dynamic>? filterQuery;
  Map<String,dynamic>? searchQuery;
  bool isFilterApplied = false;



  Future<void> searchProducts() async{
    searchList.clear();
    searchQuery = {
      "name":'ilike.*${searchController.text}*'
    };
    if(isFilterApplied){
      searchQuery?.addAll(filterQuery!);
    }
    emit(SearchProductsLoadingState());
    try{
      Response response =  await DioHelper.get(
          endPoint: EndPoints.products,
      queryParameters:searchQuery);
      for(var i in response.data){
        searchList.add(ProductModel.fromJson(i));
      }
      emit(SearchProductsSuccessState());
    }catch(e){
      log(e.toString());
      emit(SearchProductsErrorState());
    }
  }

  void clearSearch(){
    searchController.clear();
    if(!isFilterApplied){
      searchList.clear();
    }
    emit(ClearSearchState());
  }

  void selectCategory(int index){
    //check first if the clicked one is selected to toggle it
    if(filterCategoryList[index].isSelected){
      filterCategoryList[index].isSelected = false;
    }else{
      //if not selected before or first time
      _clearCategoryFilter();
      filterCategoryList[index].isSelected = true;
    }
    emit(SelectCategorySuccessState());
  }

  void selectPrice(double end){
    endPrice = end;
    emit(SelectPriceSuccessState());
  }


  Future<void> applyFilter() async{
    searchList.clear();
    int selectedCategory = _getSelectedCategory();
    if(selectedCategory != -1 ){
      filterQuery = {
        "category": "eq.${filterCategoryList[selectedCategory].category}",
        "price_after_discount" :"lte.${endPrice.toInt()}"
      };
    }else{
      filterQuery = {
        "price_after_discount" :"lte.${endPrice.toInt()}"
      };
    }
    emit(ApplyFilterLoadingState());

    try{
      Response response = await DioHelper.get(
          endPoint: EndPoints.products,
          queryParameters: filterQuery
      );
      for(var i in response.data){
        searchList.add(ProductModel.fromJson(i));
      }
      isFilterApplied = true;
      clearSearch();
      emit(ApplyFilterSuccessState());
    }catch(e){
      log(e.toString());
      emit(ApplyFilterErrorState());
    }
  }

  int _getSelectedCategory(){
    for(var i=0;i<filterCategoryList.length;i++){
      if(filterCategoryList[i].isSelected){
        return i;
      }
    }
    return -1;
  }

  void clearFilter(){
    if(searchController.text.isEmpty){
      searchList.clear();
    }
    endPrice = 1000.0;
    _clearCategoryFilter();
    isFilterApplied = false;
    emit(ClearFilterSuccessState());
  }

  void _clearCategoryFilter(){
    for(var element in filterCategoryList){
      element.isSelected = false;
    }
  }
}