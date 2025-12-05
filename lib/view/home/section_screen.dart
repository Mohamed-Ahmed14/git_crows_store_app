import 'package:clothing_store/view/home/product_widget.dart';
import 'package:clothing_store/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionScreen extends StatelessWidget {
  final bool isPopular;
  const SectionScreen({required this.isPopular,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed:(){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded,color: Theme.of(context).secondaryHeaderColor,)),
        title:Text(isPopular? 'Popular Products':'Recommended Products',
          style: Theme.of(context).textTheme.bodyMedium,),
      ),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: 0.75,mainAxisSpacing: 40.h,crossAxisSpacing: 40.w),
          padding: EdgeInsetsDirectional.all(30.w),
          itemCount:isPopular?
          HomeCubit.get(context).popularProductsList.length:HomeCubit.get(context).recommendedList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ProductWidget(productModel:isPopular?
            HomeCubit.get(context).popularProductsList[index]:HomeCubit.get(context).recommendedList[index]);
          },)
    );
  }
}
