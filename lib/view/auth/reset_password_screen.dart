import 'package:clothing_store/view/auth/login_screen.dart';
import 'package:clothing_store/view/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/cubit/auth_cubit/auth_cubit.dart';
import '../../view_model/cubit/auth_cubit/auth_state.dart';
import '../../view_model/utilities/colors.dart';
import '../widgets/custom_progress_indicator.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _resetPassKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },
                icon: Icon(Icons.arrow_back_outlined,color: Theme.of(context).secondaryHeaderColor,)),
            title: Text("Reset Password",style:Theme.of(context).textTheme.bodyLarge),
          ),
          body: BlocConsumer<AuthCubit,AuthenticationState>(
            listenWhen:(previous, current) {
             return (current is UpdatePassErrorState) ||
                 (current is UpdatePassSuccessState && !AuthCubit.get(context).didShowSnackBar);
            },
            listener: (context, state){
              if(state is UpdatePassErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error Updating Password",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,),
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    duration:const Duration(seconds: 2),),
                );
              }
              if(state is UpdatePassSuccessState){
                AuthCubit.get(context).didShowSnackBar = true;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Password Updated Successfully",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,),
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    duration:const Duration(seconds: 1),),
                );
                AuthCubit.get(context).clearControllersAndVisibility();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),),
                      (route) => false,);
              }
            },
            builder: (context, state) {
              var cubit = AuthCubit.get(context);
              return Form(
                key: _resetPassKey,
                child: ListView(
                  padding: EdgeInsetsDirectional.only(top: 120.h, start: 40.w, end: 40.w),
                  children: [
                    ///Store Title
                    Text(
                      'Enter your New Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 60.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    ///TextFormField For New Password
                    CustomTextForm(controller: cubit.passwordController,
                    validator: cubit.validator,
                    hintText: 'New Password',
                    obscureText: cubit.isHidden,
                    suffixIcon: IconButton(onPressed: (){
                      cubit.isSecure();
                    },
                        icon: Icon(
                          cubit.isHidden?Icons.visibility_off_outlined:Icons.visibility_outlined,
                          color: AppColors.grey,)
                    ),),
                    SizedBox(
                      height: 40.h,
                    ),
                    ///Elevated Button -> Login
                    SizedBox(
                      height: 120.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_resetPassKey.currentState!.validate()){
                           cubit.updatePassword();
                          }
                        },
                        child: (state is UpdatePassLoadingState)?
                        CustomProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ):Text(
                          'Update Password',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 60.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              );
            },

          ),
        ),
      ),
    );
  }
}
