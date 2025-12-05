
// import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:clothing_store/model/profile_model/account_details_model.dart';
import 'package:clothing_store/view_model/cubit/auth_cubit/auth_state.dart';
import 'package:clothing_store/view_model/cubit/profile_cubit/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



class AuthCubit extends Cubit<AuthenticationState>{

  AuthCubit():super(AuthInitState());
 static AuthCubit get(context)=>BlocProvider.of<AuthCubit>(context);

 //TextEditingController
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController passwordConfirmController = TextEditingController();

  //Focus node-> Login
  FocusNode loginEmailNode = FocusNode();
  FocusNode loginPassNode =FocusNode();
  //Focus node->Signup
  FocusNode signupEmailNode = FocusNode();
  FocusNode signupNameNode =FocusNode();
  FocusNode signupPassNode = FocusNode();
  // FocusNode signupPassConfirmNode =FocusNode();
  //Focus node-> ResetPassword
  FocusNode resetPasswordNode = FocusNode();





  //Password Visibility
  bool isHidden = true;

//supabase client
var client = Supabase.instance.client;

//TextFormField Validator
  String? validator(String? value){
    if(value!.isEmpty){
      return "This field can't be empty";
    }
   return null;
  }

  //Is password hidden
  void isSecure(){
    isHidden = !isHidden;
    emit(ChangeVisibilityState());
  }

  //Clear Controllers & set isHidden = true
  void clearControllersAndVisibility(){
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    isHidden = true;
    // passwordConfirmController.clear();
  }

//Login
Future<void> login()async{
  emit(LoginLoadingState());
  try{
    await client.auth.signInWithPassword(
      email: emailController.text,
        password: passwordController.text);

    emit(LoginSuccessState());
  }on AuthException catch(e){
    log(e.toString());
    emit(LoginErrorState(e.message));
    rethrow;
  }
  catch(e){
    log(e.toString());
    emit(LoginErrorState(e.toString()));
    rethrow;
  }
}

//Signup
Future<void> signupNewUser()async{
  emit(SignupLoadingState());
  try{
    await client.auth.signUp(
      email: emailController.text,
        password: passwordController.text);
    await addUserData();
    emit(SignupSuccessState());
  }on AuthException catch(e){
    log(e.toString());
    emit(SignupErrorState(e.message));
    rethrow;
  }catch(e){
    log(e.toString());
    emit(SignupErrorState(e.toString()));
    rethrow;
  }
}



GoogleSignInAccount? googleUser;

  Future<AuthResponse> signInWithGoogle() async {
    emit(GoogleSignInLoadingState());
    const webClientId = '889378011026-prdb4r3rro22nlin497ve8mfdvs50d2e.apps.googleusercontent.com';
     final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    // Force sign out to trigger account chooser
    await googleSignIn.signOut();
     googleUser = await googleSignIn.signIn();
     if(googleUser == null){
       emit(GoogleSignInErrorState());
       return AuthResponse();
     }
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null ||idToken == null) {
      emit(GoogleSignInErrorState());
      return AuthResponse();
    }


    AuthResponse  response = await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    await addUserData(userName: googleUser!.displayName,userEmail: googleUser!.email);
    emit(GoogleSignInSuccessState());
    return response;

  }

  Future<void> logout ()async{
    emit(LogoutLoadingState());
    try{
      await client.auth.signOut();
      //may be we don't need it
      //await googleSignIn?.signOut();
      emit(LogoutSuccessState());
    }catch(e){
      emit(LogoutErrorState());
      rethrow;
    }
  }

  Future<void> resetPasswordSendEmail()async{
    emit(SendEmailResetPassLoadingState());
    try{
      await client.auth.resetPasswordForEmail(
        emailController.text,
        //For deep links
        redirectTo: 'myapp://reset-password',
      );
      emit(SendEmailResetPassSuccessState());
    } catch(e){
      emit(SendEmailResetPassErrorState());
      rethrow;
    }
  }

  final appLinks = AppLinks();
void checkForgetPassLink(){
  appLinks.uriLinkStream.listen((Uri uri) {
    if (uri.toString().contains('reset-password')) {
      emit(ForgetPasswordState());
    }
  });
}


bool didShowSnackBar = false;

  Future<void> updatePassword() async{
    emit((UpdatePassLoadingState()));
    try{
      await client.auth.updateUser(
        UserAttributes(
          password: passwordController.text,
        ),
      );
      emit(UpdatePassSuccessState());
    }catch(e){
      log(e.toString());
      emit(UpdatePassErrorState());
    }
  }



  ///Deal with supabase database
  //Added User Data
Future<void> addUserData({String? userName,String? userEmail})async{
    emit(UserDataAddedLoadingState());
    try{
      //best practice is to add table names in constant file
      await client
          .from('users')
          .insert({
        'name': userName??nameController.text,
        'email':userEmail?? emailController.text,
        'id':client.auth.currentUser!.id,
          });
      emit(UserDataAddedSuccessState());
    }catch(e){
      //remove it after finishing debug
      log(e.toString());
      emit(UserDataAddedErrorState());
    }
}


}