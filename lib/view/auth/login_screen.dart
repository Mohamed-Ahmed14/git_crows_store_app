import 'package:clothing_store/view/auth/forget_password_screen.dart';
import 'package:clothing_store/view/auth/reset_password_screen.dart';
import 'package:clothing_store/view/auth/signup_screen.dart';
import 'package:clothing_store/view/layout/layout_screen.dart';
import 'package:clothing_store/view_model/cubit/auth_cubit/auth_cubit.dart';
import 'package:clothing_store/view_model/cubit/auth_cubit/auth_state.dart';
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/cubit/layout_cubit/layout_cubit.dart';
import '../widgets/custom_progress_indicator.dart';
import '../widgets/custom_text_form.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthCubit.get(context).checkForgetPassLink();
  }
  @override
  Widget build(BuildContext context) {
    ///onTap for Facebook
    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: BlocConsumer<AuthCubit,AuthenticationState>(
            listener: (context, state) {
              if(state is LoginErrorState){
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
              if(state is LoginSuccessState || state is GoogleSignInSuccessState){
                LayoutCubit.get(context).setNewIndex(0);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LayoutScreen(),));
              }
              if(state is ForgetPasswordState){
                AuthCubit.get(context).clearControllersAndVisibility();
                AuthCubit.get(context).didShowSnackBar = false;
                Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(),));
              }
            },
            builder: (context, state) {
              var cubit = AuthCubit.get(context);
              return Form(
                key: _loginKey,
                child: ListView(
                  padding:
                  EdgeInsetsDirectional.only(top: 120.h, start: 40.w, end: 40.w),
                  children: [
                    ///Store Title
                    Text(
                      'CROWS',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Welcome Back',
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
                    CustomTextForm(
                      controller: cubit.emailController,
                      validator: cubit.validator,
                      focusNode: cubit.loginEmailNode,
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ///TextFormField 2 For Password
                    CustomTextForm(
                        controller: cubit.passwordController,
                    validator: cubit.validator,
                    hintText: 'Password',
                    focusNode: cubit.loginPassNode,
                      obscureText: cubit.isHidden,
                    suffixIcon: IconButton(onPressed: (){
                      cubit.isSecure();
                    },
                        icon: Icon(
                          cubit.isHidden?Icons.visibility_off_outlined:Icons.visibility_outlined,
                          color: AppColors.grey,)
                    ),),
                    SizedBox(
                      height: 20.h,
                    ),
                    ///Forget Password Implementation
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen(),));
                      },
                          child: Text('Forget Password?',
                              style: Theme.of(context).textTheme.bodySmall),),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ///Elevated Button -> Login
                    SizedBox(
                      height: 120.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_loginKey.currentState!.validate()){
                            cubit.login();
                          }
                        },
                        child: (state is LogoutLoadingState)?
                        CustomProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ):Text(
                          'Login',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 60.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
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
                            'Or continue with',
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
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextButton(
                            onPressed: (){
                              cubit.clearControllersAndVisibility();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ));
                            },
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.indigo,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.indigo,
                              ),
                              textAlign: TextAlign.end,
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


