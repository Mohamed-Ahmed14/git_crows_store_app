

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/colors.dart';
//
// final baseDark = ThemeData(
//   useMaterial3: true,
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: Colors.white,
//     brightness: Brightness.dark,
//   ),
// );
//
// ThemeData darkTheme = baseDark.copyWith(
//   scaffoldBackgroundColor: AppColors.black,
//   appBarTheme: AppBarTheme(
//     backgroundColor: AppColors.black,
//     centerTitle: true,
//     foregroundColor: AppColors.white,
//   ),
//
//   textTheme: baseDark.textTheme.copyWith(
//     bodySmall: baseDark.textTheme.bodySmall!.copyWith(
//       color: AppColors.white,
//       fontSize: 14.sp,
//     ),
//     bodyMedium: baseDark.textTheme.bodyMedium!.copyWith(
//       color: AppColors.white,
//       fontSize: 18.sp,
//     ),
//     bodyLarge: baseDark.textTheme.bodyLarge!.copyWith(
//       color: AppColors.white,
//       fontSize: 22.sp,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
//
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: AppColors.white,
//       foregroundColor: AppColors.black,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//     ),
//   ),
//
//   inputDecorationTheme: InputDecorationTheme(
//     fillColor: AppColors.black,
//     filled: true,
//     hintStyle: TextStyle(color: AppColors.grey),
//     contentPadding: EdgeInsetsDirectional.all(30.w),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(20.r),
//       borderSide: BorderSide(color: AppColors.grey),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(20.r),
//       borderSide: BorderSide(color: AppColors.grey),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(20.r),
//       borderSide: BorderSide(color: AppColors.grey),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(20.r),
//       borderSide: BorderSide(color: AppColors.red),
//     ),
//   ),
//
//   textButtonTheme: TextButtonThemeData(
//     style: TextButton.styleFrom(
//       padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
//       alignment: AlignmentDirectional.centerStart,
//       overlayColor: AppColors.transparent,
//     ),
//   ),
//
//   dividerTheme: DividerThemeData(
//     color: AppColors.white,
//   ),
// );
//

//old trying

ThemeData darkTheme = ThemeData(
 useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    brightness: Brightness.dark,
  ),
  primaryColor: AppColors.black,
 // primaryColorLight: AppColors.white,
  secondaryHeaderColor: AppColors.white,
  scaffoldBackgroundColor: AppColors.black,

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.black,
    //elevation: 0,
    centerTitle: true,
    foregroundColor: AppColors.white,
  ),
  textTheme: ThemeData.dark().textTheme.copyWith(
    bodySmall: TextStyle(
        color: AppColors.white,
        fontSize: 45.sp
    ),
    bodyLarge: TextStyle(
        color: AppColors.white,
        fontSize: 75.sp,
        fontWeight: FontWeight.bold
    ),
    bodyMedium: TextStyle(
      color: AppColors.white,
      fontSize: 55.sp,
    ),
  ),
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

