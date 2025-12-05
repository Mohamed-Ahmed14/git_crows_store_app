import 'package:clothing_store/model/product_model/product_color_model.dart';
import 'package:clothing_store/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/utilities/colors.dart';

class ProductColorWidget extends StatelessWidget {
  final ProductColorModel productColorModel;
  final int index;
  const ProductColorWidget({required this.index,required this.productColorModel,super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        HomeCubit.get(context).changeSelectedColor(index);
      },
      child: CircleAvatar(
        backgroundColor: productColorModel.isSelected
            ? AppColors.shadowGrey
            : Colors.transparent,
        radius: 40.r,
        child: Icon(
          Icons.circle,
          color: productColorModel.colorValue,
          size: 80.r,
        ),
      ),
    );
  }
}
