
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//
// final base = ThemeData(
//   useMaterial3: true,
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: Colors.black,
//     brightness: Brightness.light,
//   ),
// );
//
// ThemeData lightTheme = base.copyWith(
//   scaffoldBackgroundColor: AppColors.white,
//
//   appBarTheme: AppBarTheme(
//     backgroundColor: AppColors.white,
//     centerTitle: true,
//     foregroundColor: AppColors.black,
//   ),
//
//   textTheme: base.textTheme.copyWith(
//     bodySmall: base.textTheme.bodySmall!.copyWith(
//       color: AppColors.black,
//       fontSize: 14.sp,
//     ),
//     bodyMedium: base.textTheme.bodyMedium!.copyWith(
//       color: AppColors.black,
//       fontSize: 18.sp,
//     ),
//     bodyLarge: base.textTheme.bodyLarge!.copyWith(
//       color: AppColors.black,
//       fontSize: 22.sp,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
//
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: AppColors.black,
//       foregroundColor: AppColors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//     ),
//   ),
//
//   inputDecorationTheme: InputDecorationTheme(
//     fillColor: AppColors.transparent,
//     filled: true,
//     hintStyle: TextStyle(color: AppColors.grey),
//     contentPadding: EdgeInsetsDirectional.all(30.w),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(20.r),
//       borderSide: BorderSide(color: AppColors.black),
//     ),
//   ),
// );

//old trying

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.black,
    brightness: Brightness.light,
  ),
  primaryColor: AppColors.white,
  hintColor: AppColors.black,
  secondaryHeaderColor: AppColors.black,
  scaffoldBackgroundColor: AppColors.white,
 // primaryColorLight: AppColors.black,

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    //elevation: 0,
    centerTitle: true,
    foregroundColor: AppColors.black,
  ),
  textTheme: ThemeData.light().textTheme.copyWith(
    bodySmall: TextStyle(
        color: AppColors.black,
        fontSize: 45.sp
    ),
    bodyLarge: TextStyle(
        color: AppColors.black,
        fontSize: 75.sp,
        fontWeight: FontWeight.bold
    ),
    bodyMedium: TextStyle(
      color: AppColors.black,
      fontSize: 55.sp,
    ),
  ),

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

