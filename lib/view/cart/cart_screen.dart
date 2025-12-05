import 'package:clothing_store/view/cart/shipping_details_screen.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_cubit.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cart_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    // TODO: implement initState
    OrderCubit.get(context).getCartItems();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        // leading: IconButton(onPressed: (){
        //   LayoutCubit.get(context).setNewIndex(0);
        //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LayoutScreen() ,),
        //       (route) => false,);
        // },
        //     icon: Icon(Icons.arrow_back_rounded,color: Theme.of(context).secondaryHeaderColor,)),
        title: Text('My Cart',style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 60.sp,
            fontWeight: FontWeight.w700
        ),),
      ),
      body: BlocConsumer<OrderCubit,OrderState>(
        listener: (context, state) {
          if(state is GetCartItemsErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to load cart items',textAlign: TextAlign.center,),
                duration: const Duration(seconds: 2),),
            );
          }else if(state is UpdateCartItemQuantityErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Something went wrong, please try again',textAlign: TextAlign.center,),
                duration: const Duration(seconds: 2),),
            );
          }
        },
        builder: (context, state) {
          var cubit = OrderCubit.get(context);
          return state is GetCartItemsLoadingState || state is RemoveFromCartLoadingState
              ? Center(child: CircularProgressIndicator())
              : cubit.cartItems.isEmpty
                  ? Center(child: Text('Your cart is empty'))
                  : ListView(
            padding: EdgeInsetsDirectional.only(top:50.h,start: 50.w,end: 50.w,
              bottom: MediaQuery.of(context).padding.bottom,),
            shrinkWrap: true,
            children: [
              ListView.separated(
                  padding: EdgeInsetsDirectional.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CartWidget(cartItem: cubit.cartItems[index],);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20.h,);
                  },
                  itemCount: cubit.cartItems.length),
              SizedBox(height: 40.h,),
              Text("Total Price: ${cubit.totalCartPrice} LE",style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,),
              SizedBox(height: 40.h,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 20.h),
                ),
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShippingDetailsScreen(),));
                },
                child: Text('Checkout',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700
                ),), ),
            ],
          );
        },

      ),

    );
  }
}
