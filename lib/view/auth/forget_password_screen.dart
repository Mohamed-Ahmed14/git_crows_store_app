import 'package:clothing_store/view/widgets/custom_text_form.dart';
import 'package:clothing_store/view_model/cubit/auth_cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/cubit/auth_cubit/auth_cubit.dart';
import '../widgets/custom_progress_indicator.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _forgetPassKey = GlobalKey<FormState>();
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
            listener: (context, state) {
              if(state is SendEmailResetPassErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error Sending Email",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,),
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    duration:const Duration(seconds: 2),),
                );
              }
              if(state is SendEmailResetPassSuccessState){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Email is sent",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,),
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
                      duration:const Duration(seconds: 2),),
                );
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              var cubit = AuthCubit.get(context);
              return Form(
                key: _forgetPassKey,
                child: ListView(
                  padding: EdgeInsetsDirectional.only(top: 120.h, start: 40.w, end: 40.w),
                  children: [
                    ///Store Title
                    Text(
                      'Enter your email to reset password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 60.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    ///TextFormField 1 For Email
                    CustomTextForm(controller: cubit.emailController,
                    validator: cubit.validator,
                    focusNode: cubit.resetPasswordNode,
                    hintText: 'Email',),
                    SizedBox(
                      height: 40.h,
                    ),
                    ///Elevated Button -> Login
                    SizedBox(
                      height: 120.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_forgetPassKey.currentState!.validate()){
                            cubit.resetPasswordSendEmail();
                          }
                        },
                        child: (state is SendEmailResetPassLoadingState)?
                        CustomProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ):Text(
                          'Send',
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
