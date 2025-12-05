import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_new_card_screen.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(Icons.arrow_back_outlined,color: Theme.of(context).secondaryHeaderColor,)),
        title: Text('Payment Methods',style: Theme.of(context).textTheme.bodyLarge,),
      ),
      body: ListView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 48.h) ,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("My cards",style: Theme.of(context).textTheme.bodyMedium,),
              InkWell(
                onTap: (){
                  // Navigate to add new card screen
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewCardScreen(),));
                },
                child: Text("Add Card",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w700
                ),),
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 24.h),
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: ListView.separated(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Image.asset('assets/images/profile_images/mastercard.png',
                        width: 48.w,height: 24.h,
                      ),
                      SizedBox(width: 40.w,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mohamed Ahmed Farouk',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),),
                            Text('5710********5609',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),),
                            Text('Expire Date: 08/25',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),),
                          ],
                        ),
                      ),
                      IconButton(onPressed:(){},
                          icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,)),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: AppColors.grey,
                    thickness: 1.h,
                  );
                },
                itemCount: 4)
          ),

          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("My Wallets",style: Theme.of(context).textTheme.bodyMedium,),
              InkWell(
                onTap: (){
                  // Navigate to add new card screen

                },
                child: Text("Add Wallet",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w700
                ),),
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 24.h),
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Icon(Icons.account_balance_wallet_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 48.r,
                        ),
                        SizedBox(width: 40.w,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Mohamed Ahmed Farouk',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),),
                              Text('0102156369',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),),

                            ],
                          ),
                        ),
                        IconButton(onPressed:(){},
                            icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,)),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: AppColors.grey,
                      thickness: 1.h,
                    );
                  },
                  itemCount: 4)
          ),
        ],
      ),
    );
  }
}
