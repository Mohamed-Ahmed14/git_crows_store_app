import 'package:clothing_store/view/widgets/custom_progress_indicator.dart';
import 'package:clothing_store/view/home/basic_category_widget.dart';
import 'package:clothing_store/view/home/section_screen.dart';
import 'package:clothing_store/view/home/product_widget.dart';
import 'package:clothing_store/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:clothing_store/view_model/cubit/home_cubit/home_state.dart';
import 'package:clothing_store/view_model/cubit/theme_cubit/theme_cubit.dart';
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    HomeCubit.get(context).getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/app_logo/logo_light.png',
        width: 120.w,height: 120.h,fit: BoxFit.cover,color: Theme.of(context).secondaryHeaderColor,),
        title: Text('Crows Store',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 60.sp
        ),
        ),
        actions: [

          IntrinsicHeight(
            child: IntrinsicWidth(
              child: Stack(
                //alignment: AlignmentDirectional.topEnd,
                children: [
                  Icon(Icons.notifications_none_rounded),
                  PositionedDirectional(
                    top: 10.h,
                    end: 10.w,
                    child: CircleAvatar(
                      backgroundColor: AppColors.red,
                      radius: 12.r,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20.w,),
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 20.w,),
          InkWell(
            onTap: (){
              ThemeCubit.get(context).toggleTheme();
            },
            child: Icon(ThemeCubit.get(context).isLightTheme?Icons.dark_mode_outlined:Icons.light_mode,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          SizedBox(width: 20.w,),
        ],
      ),

      body: BlocBuilder<HomeCubit,HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          if(state is GetAllProductLoadingState){
            return CustomProgressIndicator(
              color: Theme.of(context).secondaryHeaderColor,
            );
          }else if(state is GetAllProductErrorState){
            return Center(child:
            Text('Something went wrong,try again...',
              style: Theme.of(context).textTheme.bodyMedium,),);
          }else{
            return Padding(
              padding: EdgeInsetsDirectional.all(30.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Categories Section [man,woman,accessories,beauty]
                    // SizedBox(
                    //   height: 200.h,
                    //   width: double.infinity,
                    //   child: ListView.separated(
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (context, index) {
                    //       return BasicCategoryWidget(
                    //           basicCategoryModel: cubit.basicCategoryList[index]);
                    //     },
                    //     separatorBuilder: (context, index) {
                    //       return SizedBox(width: 120.w,);
                    //     },
                    //     itemCount: cubit.basicCategoryList.length,),
                    // ),
                    SizedBox(height: 40.h,),
                    ///New Collection Section
                    IntrinsicHeight(
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                            child: Image.asset('assets/images/home_images/brand2.jpeg',
                              width: double.infinity,height: 400.h,fit: BoxFit.cover,),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(30.0.w),
                            child: Text('Winter \nCollection \n2026',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                              //   style: TextStyle(
                              //   color: Colors.white,fontSize: 50.sp,fontWeight: FontWeight.bold
                              // ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    ///Popular Products Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Popular Products',
                          style: Theme.of(context).textTheme.bodyMedium,),
                        TextButton(onPressed:(){
                          ///Must implement function for show all
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SectionScreen(isPopular: true,),));
                        },
                          child: Text('show all',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),),

                      ],
                    ),
                    SizedBox(height: 5.h,),
                    SizedBox(
                      height: 550.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ProductWidget(productModel: cubit.popularProductsList[index]);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 30.w,);
                          },
                          itemCount:cubit.popularProductsList.length),
                    ),
                    ///Most Recommended Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recommended',
                          style: Theme.of(context).textTheme.bodyMedium,),
                        TextButton(onPressed:(){
                          ///Must implement function for show all
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SectionScreen(isPopular: false,),));
                        },
                          child: Text('show all',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey
                            ),),),

                      ],
                    ),
                    SizedBox(height: 5.h,),
                    SizedBox(
                      height: 550.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ProductWidget(productModel: cubit.recommendedList[index]);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 30.w,);
                          },
                          itemCount: cubit.recommendedList.length),
                    ),
                    // Text("${DateTime.now().year.toString()} - ${DateTime.now().month.toString()} - ${DateTime.now().day.toString()}"),
                    SizedBox(height:  MediaQuery.of(context).padding.bottom,),

                  ],
                ),
              ),
            );
          }

        },
      ),
    );
  }
}
