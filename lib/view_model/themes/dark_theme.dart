

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/colors.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: AppColors.black,
 // primaryColorLight: AppColors.white,
  secondaryHeaderColor: AppColors.white,
  scaffoldBackgroundColor: AppColors.black,

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.black,
    centerTitle: true,
    foregroundColor: AppColors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
        color: AppColors.white,
        fontSize: 75.sp,
        fontWeight: FontWeight.bold
    ),
    bodyMedium: TextStyle(
      color: AppColors.white,
      fontSize: 55.sp,
    ),
    bodySmall: TextStyle(
        color: AppColors.white,
        fontSize: 45.sp
    ),
  ),
  // primaryTextTheme: TextTheme(
  //   bodyLarge: TextStyle(
  //       color: AppColors.white,
  //       fontSize: 75.sp,
  //       fontWeight: FontWeight.bold
  //   ),
  //   bodyMedium: TextStyle(
  //     color: AppColors.white,
  //     fontSize: 55.sp,
  //   ),
  //   bodySmall: TextStyle(
  //       color: AppColors.white,
  //       fontSize: 45.sp
  //   ),
  // ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.grey
    ),
    fillColor: AppColors.black,
    filled: true,
    contentPadding: EdgeInsetsDirectional.all(30.w),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: AppColors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: AppColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: AppColors.grey),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: AppColors.red),
    ),

  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
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
      color: AppColors.white
  ),

);