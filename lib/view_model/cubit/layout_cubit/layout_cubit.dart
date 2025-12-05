

import 'package:clothing_store/view/cart/cart_screen.dart';

import 'package:clothing_store/view/favourite/favourite_screen.dart';
import 'package:clothing_store/view/home/home_screen.dart';
import 'package:clothing_store/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view/search/search_screen.dart';
import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState>{
  LayoutCubit():super(LayoutInitState());
  static LayoutCubit get(context)=>BlocProvider.of<LayoutCubit>(context);

  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    FavouriteScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  int currentIndex = 0;

  void setNewIndex(int newIndex){
    currentIndex = newIndex;
    //may be need emit new state
    emit(LayoutChangeState());
  }

}