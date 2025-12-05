import 'dart:developer';

import 'package:clothing_store/model/profile_model/profile_model.dart';
import 'package:clothing_store/view/profile/account_details_screen.dart';
import 'package:clothing_store/view_model/cubit/profile_cubit/profile_state.dart';
import 'package:clothing_store/view_model/data/network/dio_helper.dart';
import 'package:clothing_store/view_model/data/network/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../coming_soon_screen.dart';
import '../../../model/order_model/order_item_model.dart';
import '../../../model/order_model/orders_model.dart';
import '../../../model/profile_model/account_details_model.dart';
import '../../../view/profile/orders/orders_screen.dart';
import '../../../view/profile/payment_method_screen.dart';

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit():super(ProfileInitState());

  static ProfileCubit get(context)=>BlocProvider.of<ProfileCubit>(context);

  //Database client
  var client = Supabase.instance.client;

  //List of general rules in Profile

List<ProfileModel> profileGeneralList =[
  ProfileModel(
      icon:Icons.person,
      title: 'Account Details',
      description: 'Edit your account information',
  screen: AccountDetailsScreen()),
  ProfileModel(
      icon: Icons.credit_card_rounded,
      title: 'Payment Method',
      description: 'Add your credit or debit card',
      screen: PaymentMethodScreen()),
  ProfileModel(
      icon: Icons.receipt_rounded,
      title: 'Orders',
      description: 'View your orders',
      screen: OrdersScreen()),
  ProfileModel(
      icon: Icons.security_rounded,
      title: 'Security & Password',
      description: 'Edit your password',
      screen: ComingSoonScreen()),
];

  //List of Settings rules in Profile
  List<ProfileModel> profileSettingsList =[
    ProfileModel(
        icon: Icons.notifications_none_rounded,
        title: 'Notifications',
        description: 'Manage your notification',
        screen: ComingSoonScreen()),
    ProfileModel(
        icon: Icons.language_rounded,
        title: 'Language',
        description: '',
        screen: ComingSoonScreen()),
    ProfileModel(
        icon: Icons.error_outline_rounded,
        title: 'Privacy & Policy',
        description: '',
        screen: ComingSoonScreen()),
    ProfileModel(
        icon: Icons.phone,
        title: 'Contact Us',
        description: '',
        screen: ComingSoonScreen()),
  ];

  TextEditingController userNameController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController userMobileController = TextEditingController();

  FocusNode userNameNode = FocusNode();
  FocusNode userAddressNode = FocusNode();
  FocusNode userMobileNode = FocusNode();

  //Get User Data
  AccountDetailsModel? accountDetailsModel;
  Future<void> getUserDate()async{
    emit(GetUserDataLoadingState());
    try{
      final data = await client
          .from('users')
          .select().eq("id", client.auth.currentUser!.id);
      accountDetailsModel = AccountDetailsModel.fromJson(json: data[0]);
      await setControllers();
      emit(GetUserDataSuccessState());
    }catch(e){
      emit(GetUserDataErrorState());
    }
  }

  void clearControllers(){
    userNameController.clear();
    userAddressController.clear();
    userMobileController.clear();
  }
  Future<void> setControllers() async{
    userNameController.text = accountDetailsModel?.name ?? "";
    userAddressController.text = accountDetailsModel?.address ?? "";
    userMobileController.text = accountDetailsModel?.phone ?? "";
    emit(SetControllerSuccessState());
  }

  bool isEdit = false;
  void changeEditSaveBtn()async{
    isEdit = !isEdit;
    if(isEdit == false){
      await updateUserData();
    }
    emit(ChangeEditSaveBtnState());
  }
  //Update User Data
  Future<void> updateUserData() async{
    AccountDetailsModel newData = AccountDetailsModel(
      name: userNameController.text,
      address: userAddressController.text,
      phone: userMobileController.text
    );
      emit(UpdateUserDataLoadingState());
      try{
        var data = await client.from('users').update(newData.toJson())
            .eq('id', client.auth.currentUser!.id);
        log(data.toString());
        emit(UpdateUserDataSuccessState());
      }catch(e){
        log(e.toString());
        emit(UpdateUserDataErrorState());
      }
      //Get User Data After update to display it also if error is happen restored the
    //saved data from db and display it
      await getUserDate();
  }

  //Orders History
  List<OrdersModel> ordersList = [];
  Future<void> getOrdersHistory()async{
    ordersList.clear();
    emit(GetOrdersLoadingState());
    try{
      var response = await DioHelper.get(endPoint: 'orders',
          queryParameters: {
            'user_id': "eq.${client.auth.currentUser!.id}",
          });
      for(var order in response.data){
        ordersList.add(OrdersModel.fromJson(order));
      }
      log(response.data.toString());
      emit(GetOrdersSuccessState());
    }catch(e){
      log(e.toString());
      emit(GetOrdersErrorState());
    }
  }

  //Get Order Details
  List<OrderItemModel> orderItemsList = [];
  Future<void> getOrderDetails(String? orderId)async{
    orderItemsList.clear();
    emit(GetOrderDetailsLoadingState());
    try{
      var response = await DioHelper.get(endPoint: EndPoints.orderItems,
          queryParameters: {
            'order_id': "eq.$orderId",
          });
      for(var item in response.data){
        orderItemsList.add(OrderItemModel.fromJson(item));
      }
      log(response.data.toString());
      emit(GetOrderDetailsSuccessState());
    }catch(e){
      log(e.toString());
      emit(GetOrderDetailsErrorState());
    }
  }

}