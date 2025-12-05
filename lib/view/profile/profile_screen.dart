import 'package:clothing_store/view/auth/login_screen.dart';
import 'package:clothing_store/view/widgets/custom_progress_indicator.dart';
import 'package:clothing_store/view/profile/profile_widget.dart';
import 'package:clothing_store/view_model/cubit/auth_cubit/auth_cubit.dart';
import 'package:clothing_store/view_model/cubit/auth_cubit/auth_state.dart';
import 'package:clothing_store/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:clothing_store/view_model/cubit/layout_cubit/layout_cubit.dart';
import 'package:clothing_store/view_model/cubit/profile_cubit/profile_cubit.dart';
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        // leading: Icon(Icons.arrow_back_rounded,
        //   color: Theme.of(context).secondaryHeaderColor,),
        title: Text('My Account',style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 60.sp,
            fontWeight: FontWeight.w700
        ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 60.w,end: 60.h,
        top: 30.h,),
       // bottom: kBottomNavigationBarHeight),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('General',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold
              ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsetsDirectional.only(bottom: 30.h),
                itemBuilder: (context, index) {
                  return ProfileWidget(profileModel: ProfileCubit.get(context).profileGeneralList[index]);
                },
                itemCount: ProfileCubit.get(context).profileGeneralList.length,
              ),
              //SizedBox(height: 15.h,),
              Text('Settings',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold
              ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsetsDirectional.only(bottom: 30.h),
                itemBuilder: (context, index) {
                  return ProfileWidget(profileModel: ProfileCubit.get(context).profileSettingsList[index]);
                },
                itemCount: ProfileCubit.get(context).profileSettingsList.length,
              ),
              ///Logout Implementation
              BlocConsumer<AuthCubit,AuthenticationState>(
                listener: (context, state) {
                    if(state is LogoutSuccessState){
                      AuthCubit.get(context).clearControllersAndVisibility();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                    }
                },
                builder: (context, state) {
                  return Center(
                    child:(state is LogoutLoadingState)?CustomProgressIndicator(
                      color: AppColors.red,
                    ): TextButton(onPressed: (){
                      AuthCubit.get(context).logout();
                    },
                        child: Text('Log Out',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 50.sp,
                            color: AppColors.red
                        ),

                        )
                    ),
                  );
                },
              ),
              SizedBox(height:  MediaQuery.of(context).padding.bottom,),
            ],
          ),
        ),
      ),
    );
  }
}
