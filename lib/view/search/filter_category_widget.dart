import 'package:clothing_store/model/search_model/filter_model.dart';
import 'package:clothing_store/view_model/cubit/search_cubit/search_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/utilities/colors.dart';

class FilterCategoryWidget extends StatelessWidget {
  final FilterCategoryModel filterCategoryModel;
  final int index;
  const FilterCategoryWidget({
    required this.filterCategoryModel,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filterCategoryModel.isSelected? AppColors.blueGrey:AppColors.transparent,
      borderRadius: BorderRadius.circular(24.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(24.r),
        onTap: (){
          SearchCubit.get(context).selectCategory(index);
        },
        child: Container(
          padding:EdgeInsetsDirectional.all(20.w),
          decoration: BoxDecoration(

            border: Border.all(
              color: (filterCategoryModel.isSelected)?AppColors.blueGrey:Theme.of(context).secondaryHeaderColor,
              width: 5.w,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Text(filterCategoryModel.category,style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}

