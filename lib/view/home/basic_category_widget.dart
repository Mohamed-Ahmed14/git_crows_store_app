import 'package:clothing_store/model/home_model/basic_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicCategoryWidget extends StatelessWidget {
  final BasicCategoryModel basicCategoryModel;
  const BasicCategoryWidget({required this.basicCategoryModel,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.all(5.w),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color:(basicCategoryModel.isSelected?? false) ?
              Theme.of(context).secondaryHeaderColor:Colors.transparent),
              color: Theme.of(context).primaryColor
          ),
          child: CircleAvatar(
            backgroundColor:(basicCategoryModel.isSelected?? false)  ?
            Theme.of(context).secondaryHeaderColor:Colors.grey,
            radius: 50.r,
            child: Icon(basicCategoryModel.icon,size: 85.w,
            color: Theme.of(context).primaryColor,),
          ),
        ),
        Text(basicCategoryModel.category,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: (basicCategoryModel.isSelected?? false) ?
            Theme.of(context).secondaryHeaderColor:Colors.grey,fontSize: 45.sp
        ),
        //   style: TextStyle(
        //     color: (basicCategoryModel.isSelected?? false) ?Colors.black:Colors.grey,fontSize: 45.sp
        // ),
        )
      ],
    );
  }
}
