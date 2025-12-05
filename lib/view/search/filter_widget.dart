import 'package:clothing_store/view_model/cubit/search_cubit/search_cubit.dart';
import 'package:clothing_store/view_model/cubit/search_cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/utilities/colors.dart';
import 'filter_category_widget.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit,SearchState>(
      listener: (context, state) {

      },builder: (context, state) {
        var cubit = SearchCubit.get(context);
        return Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 30.w,vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h,),
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Center(
                    child: Text('Filter',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 60.sp,
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  IconButton(
                      style:IconButton.styleFrom(
                        alignment: AlignmentDirectional.topCenter,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r)
                        ),
                        // overlayColor: AppColors.transparent
                      ),
                      padding: EdgeInsetsDirectional.zero,
                      onPressed:(){},
                      icon: Icon(Icons.close,color: AppColors.red,))
                ],
              ),
              SizedBox(height: 20.h,),
              ///Category Filter
              Text("Category",style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,),
              SizedBox(height: 20.h,),
              GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            childAspectRatio: 4,crossAxisSpacing: 60.w,mainAxisSpacing: 30.h),
           padding: EdgeInsetsDirectional.all(16.w),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FilterCategoryWidget(filterCategoryModel: cubit.filterCategoryList[index],index: index,);
                },
                itemCount: cubit.filterCategoryList.length,
              ),
              SizedBox(height: 20.h,),
              ///Price Filter
              Text("Price",style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,),
              Slider(value: cubit.endPrice,
                onChanged:  (value){
               cubit.selectPrice(value);
              },
                divisions: 10,min: 0,max: 1000,
                activeColor: Theme.of(context).secondaryHeaderColor,
              ),
              // RangeSlider(
              //   values: RangeValues(cubit.startPrice, cubit.endPrice) ,
              //   onChanged: (value){
              //     cubit.selectPrice(value.start,value.end);
              // },
              //   divisions: 10,min: 0,max: 1000,
              //   // labels: RangeLabels(cubit.startPrice.toString(), cubit.endPrice.toString()),
              //   activeColor: Theme.of(context).secondaryHeaderColor,
              // ),
              Padding(
                padding:  EdgeInsetsDirectional.symmetric(horizontal: 60.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("From: 0 \$",style: Theme.of(context).textTheme.bodySmall,),
                    Text("To: ${cubit.endPrice.toInt()} \$",style: Theme.of(context).textTheme.bodySmall,),
                  ],
                ),
              ),
              SizedBox(height: 30.h,),
              ///Clear And Apply Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              side: BorderSide(color: Theme.of(context).secondaryHeaderColor)
                          ),
                        ),
                        onPressed: (){
                          cubit.clearFilter();
                          Navigator.pop(context);
                        },
                        child: Text("Clear",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                        ),)),
                  ),
                  SizedBox(width: 20.w,),
                  Expanded(
                    child: ElevatedButton(onPressed: (){
                      cubit.applyFilter();
                      Navigator.pop(context);
                    },
                        child: Text("Apply",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),)),
                  ),
                ],
              ),
            ],
          ),
        );
      },

    );
  }
}


