abstract class AuthenticationState{}
class AuthInitState extends AuthenticationState{}

//Is Password Hidden
class ChangeVisibilityState extends AuthenticationState{}

//Login states
class LoginLoadingState extends AuthenticationState{}
class LoginSuccessState extends AuthenticationState{}
class LoginErrorState extends AuthenticationState{
  final String message;
  LoginErrorState(this.message);
}

//signup states
class SignupLoadingState extends AuthenticationState{}
class SignupSuccessState extends AuthenticationState{}
class SignupErrorState extends AuthenticationState{
  final String message;
  SignupErrorState(this.message);
}

//Google Sign In states
class GoogleSignInLoadingState extends AuthenticationState{}
class GoogleSignInSuccessState extends AuthenticationState{}
class GoogleSignInErrorState extends AuthenticationState{}

//logout states
class LogoutLoadingState extends AuthenticationState{}
class LogoutSuccessState extends AuthenticationState{}
class LogoutErrorState extends AuthenticationState{}

//Reset Password states
class SendEmailResetPassLoadingState extends AuthenticationState{}
class SendEmailResetPassSuccessState extends AuthenticationState{}
class SendEmailResetPassErrorState extends AuthenticationState{}

//State when come from links
class ForgetPasswordState extends AuthenticationState{}
//Update password states
class UpdatePassLoadingState extends AuthenticationState{}
class UpdatePassSuccessState extends AuthenticationState{}
class UpdatePassErrorState extends AuthenticationState{}


//Database
//Added User Data states
class UserDataAddedLoadingState extends AuthenticationState{}
class UserDataAddedSuccessState extends AuthenticationState{}
class UserDataAddedErrorState extends AuthenticationState{}
