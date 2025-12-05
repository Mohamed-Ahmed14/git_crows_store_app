
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.white,
 // primaryColorLight: AppColors.black,
  hintColor: AppColors.black,
  secondaryHeaderColor: AppColors.black,
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    centerTitle: true,
    foregroundColor: AppColors.black,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
        color: AppColors.black,
        fontSize: 75.sp,
        fontWeight: FontWeight.bold
    ),
    bodyMedium: TextStyle(
      color: AppColors.black,
      fontSize: 55.sp,
    ),
    bodySmall: TextStyle(
        color: AppColors.black,
        fontSize: 45.sp
    ),
  ),
  // primaryTextTheme: TextTheme(
  //   bodyLarge: TextStyle(
  //   color: AppColors.black,
  //   fontSize: 75.sp,
  //   fontWeight: FontWeight.bold
  // ),
  //   bodyMedium: TextStyle(
  //     color: AppColors.black,
  //     fontSize: 55.sp,
  //   ),
  //   bodySmall: TextStyle(
  //     color: AppColors.black,
  //     fontSize: 45.sp
  //   ),
  // ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.transparent,
    filled: true,
    hintStyle: TextStyle(
        color: AppColors.grey
    ),
    contentPadding: EdgeInsetsDirectional.all(30.w),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: AppColors.black),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: AppColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: AppColors.black),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: AppColors.red),
    ),

  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
  ),

    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        padding: EdgeInsetsDirectional.symmetric(horizontal:20.w),
        alignment: AlignmentDirectional.centerStart,
        overlayColor: AppColors.transparent
    ),
  ),
  dividerTheme: DividerThemeData(
    color: AppColors.black
  ),
);