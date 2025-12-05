import 'package:clothing_store/view/profile/orders/orders_widget.dart';
import 'package:clothing_store/view/widgets/custom_progress_indicator.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_cubit.dart';
import 'package:clothing_store/view_model/cubit/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view_model/cubit/profile_cubit/profile_cubit.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  @override
  void initState() {
    // TODO: implement initState
    ProfileCubit.get(context).getOrdersHistory();
    OrderCubit.get(context).getOrderIdFromDB();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Orders',
        style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: BlocConsumer<ProfileCubit,ProfileState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);


            if(state is GetOrdersLoadingState){
              return const Center(child: CustomProgressIndicator());
            } else if(state is GetOrdersErrorState){
              return Center(
                child: Text('Something went wrong',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }else{
              return Visibility(
                visible: cubit.ordersList.isNotEmpty,
                replacement: Center(
                child: Text('No orders found',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
          ),
                child: ListView.separated(
                    padding: EdgeInsetsDirectional.all(20.w),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return OrdersWidget(ordersModel: cubit.ordersList[index], index: index);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 40.h,);
                    },
                    itemCount: cubit.ordersList.length),
              );
            }

        },
      )

    );
  }
}
