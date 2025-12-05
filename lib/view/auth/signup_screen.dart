import 'package:clothing_store/view/widgets/custom_progress_indicator.dart';
import 'package:clothing_store/view/layout/layout_screen.dart';
import 'package:clothing_store/view/widgets/custom_text_form.dart';
import 'package:clothing_store/view_model/cubit/auth_cubit/auth_cubit.dart';
import 'package:clothing_store/view_model/cubit/auth_cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/cubit/layout_cubit/layout_cubit.dart';
import '../../view_model/utilities/colors.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _signupKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ///Need to write logic , apply theme,Responsive, add Logo, Navigator,
    ///onTap for google and Facebook
    ///may change main column to ListView for scrollable.
    return SafeArea(
      child: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: BlocConsumer<AuthCubit,AuthenticationState>(
            listener: (context, state) {
              if(state is SignupErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,),
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    duration:const Duration(seconds: 2),),
                );
              }
              if(state is SignupSuccessState || state is GoogleSignInSuccessState){
                LayoutCubit.get(context).setNewIndex(0);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LayoutScreen(),));
              }

            },
            builder: (context, state) {
              var cubit = AuthCubit.get(context);
              return Form(
                key: _signupKey,
                child: ListView(
                  padding:
                  EdgeInsetsDirectional.only(top: 120.h, start: 40.w, end: 40.w),
                  children: [
                    Text('CROWS',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center),
                    Text(
                      'Create Your Account Now!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 60.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    CustomTextForm(controller:cubit.nameController,
                    validator: cubit.validator,
                    focusNode: cubit.signupNameNode,
                    hintText: 'Enter your name',),

                    SizedBox(
                      height: 40.h,
                    ),
                    ///TextFormField 1 For Email
                    CustomTextForm(controller: cubit.emailController,
                    validator: cubit.validator,
                    focusNode: cubit.signupEmailNode,
                    hintText: 'Enter your email',),

                    SizedBox(
                      height: 40.h,
                    ),

                    ///TextFormField 2 For Password
                    CustomTextForm(controller: cubit.passwordController,
                    validator: cubit.validator,
                    focusNode: cubit.signupPassNode,
                    hintText: 'Create password',
                    obscureText: cubit.isHidden,
                    suffixIcon: IconButton(onPressed: (){
                      cubit.isSecure();
                    },
                        icon: Icon(
                          cubit.isHidden?Icons.visibility_off_outlined:Icons.visibility_outlined,
                          color: AppColors.grey,)
                    ),),

                    SizedBox(
                      height: 80.h,
                    ),
                    //Elevated Button -> Sign Up
                    SizedBox(
                      height: 120.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_signupKey.currentState!.validate()) {
                            cubit.signupNewUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child:(state is SignupLoadingState)?
                            CustomProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ): Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 60.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            'Or sign up with',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),

                    ///Google and Facebook, add on Tap function
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/images/auth_images/facebook.png',
                                      color: Theme.of(context).primaryColor,
                                      width: 60.w,
                                      height: 60.h,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      'Facebook',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ))),
                        SizedBox(
                          width: 40.w,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  cubit.signInWithGoogle();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/images/auth_images/google.png',
                                      color: Theme.of(context).primaryColor,
                                      width: 60.w,
                                      height: 60.h,
                                      fit: BoxFit.fill,
                                    ),
                                    Text('Google',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w700))
                                  ],
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                            style: Theme.of(context).textTheme.bodySmall),
                        TextButton(
                            onPressed: () {
                              cubit.clearControllersAndVisibility();
                              ///check it after adding form key
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Login',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.indigo,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.indigo,
                              ),
                              textAlign: TextAlign.start,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Divider(
                        thickness: 4,
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
