
import 'package:clothing_store/view/widgets/custom_progress_indicator.dart';
import 'package:clothing_store/view/widgets/custom_text_form.dart';
import 'package:clothing_store/view_model/cubit/profile_cubit/profile_cubit.dart';
import 'package:clothing_store/view_model/cubit/profile_cubit/profile_state.dart';
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileCubit.get(context).getUserDate();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },
                icon: Icon(Icons.arrow_back_outlined,color: Theme.of(context).secondaryHeaderColor,)),
          title: Text('Account Details',style: Theme.of(context).textTheme.bodyLarge,),
          ),
          body: BlocConsumer<ProfileCubit,ProfileState>(
            listener: (context, state) {
              if(state is GetUserDataErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Can\'t get user data now',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,),
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    duration:const Duration(seconds: 2),),
                );
              }
              if(state is UpdateUserDataErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error while trying to update data',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,),
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    duration:const Duration(seconds: 2),),
                );
              }
            },
            builder: (context, state) {
              var cubit = ProfileCubit.get(context);
              if(state is GetUserDataLoadingState || state is UpdateUserDataLoadingState){
                return CustomProgressIndicator(
                  color: Theme.of(context).secondaryHeaderColor,
                );
              }else{
                return  ListView(
                  padding:
                  EdgeInsetsDirectional.only(top: 120.h, start: 40.w, end: 40.w),
                  children: [
                    ///TextFormField For User Name
                    CustomTextForm(
                      controller: cubit.userNameController,
                    focusNode: cubit.userNameNode,
                    hintText: 'User Name',
                      hintColor: Theme.of(context).secondaryHeaderColor,
                        enabled: cubit.isEdit,),
                    SizedBox(
                      height: 40.h,
                    ),
                    ///TextFormField For Email
                    CustomTextForm(
                      hintText: cubit.accountDetailsModel?.email ??'Email',
                      hintColor: AppColors.grey,
                      enabled: false,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ///TextFormField For Mobile Number
                    CustomTextForm(
                      controller: cubit.userMobileController,
                      focusNode: cubit.userMobileNode,
                      hintText: 'Mobile Number',
                      hintColor: AppColors.grey,
                      enabled: cubit.isEdit,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ///TextFormField For Address
                    CustomTextForm(
                      controller: cubit.userAddressController,
                      focusNode: cubit.userAddressNode,
                      hintText: 'Address',
                      hintColor: AppColors.grey,
                      enabled: cubit.isEdit,
                    ),

                    SizedBox(
                      height: 80.h,
                    ),
                    //Elevated Button -> Sign Up
                    SizedBox(
                      height: 120.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                         cubit.changeEditSaveBtn();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child: Text(
                         cubit.isEdit?'Save': 'Edit',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 60.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),



                  ],
                );
              }


            },
          ),
          ),
        ),

    );
  }
}
