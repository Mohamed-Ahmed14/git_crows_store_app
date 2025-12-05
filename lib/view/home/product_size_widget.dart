import 'package:clothing_store/model/product_model/product_size_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/cubit/home_cubit/home_cubit.dart';
import '../../view_model/utilities/colors.dart';

class ProductSizeWidget extends StatelessWidget {
  final ProductSizeModel productSizeModel;
  final int index;
  const ProductSizeWidget({super.key, required this.productSizeModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         HomeCubit.get(context).changeSelectedSize(index);
      },
      child: CircleAvatar(
        backgroundColor: productSizeModel.isSelected
            ? Theme.of(context)
            .secondaryHeaderColor
            : AppColors.grey,
        radius: 40.r,
        child: Text(productSizeModel.sizeName,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(
                color: Theme.of(context)
                    .primaryColor)),
      ),
    );
  }
}
