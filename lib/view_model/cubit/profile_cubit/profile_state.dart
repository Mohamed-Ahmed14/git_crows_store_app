abstract class ProfileState{}
class ProfileInitState extends ProfileState{}

//Get User Data states
class GetUserDataLoadingState extends ProfileState{}
class GetUserDataSuccessState extends ProfileState{}
class GetUserDataErrorState extends ProfileState{}

//Update User Data states
class UpdateUserDataLoadingState extends ProfileState{}
class UpdateUserDataSuccessState extends ProfileState{}
class UpdateUserDataErrorState extends ProfileState{}

class ChangeEditSaveBtnState extends ProfileState{}
class SetControllerSuccessState extends ProfileState{}


//Orders states
class GetOrdersLoadingState extends ProfileState{}
class GetOrdersSuccessState extends ProfileState{}
class GetOrdersErrorState extends ProfileState{}

//Get Order Details states
class GetOrderDetailsLoadingState extends ProfileState{}
class GetOrderDetailsSuccessState extends ProfileState{}
class GetOrderDetailsErrorState extends ProfileState{}