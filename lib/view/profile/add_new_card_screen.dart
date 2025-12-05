import 'package:clothing_store/view/widgets/custom_text_form.dart';
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewCardScreen extends StatelessWidget {
  const AddNewCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
        title: Text(
          'Add New Card',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 48.0.w, vertical: 24.0.h),
        children: [
          SizedBox(height: 40.h,),
          Image.asset("assets/images/profile_images/credit_card_image.png",
          width: double.infinity,fit: BoxFit.cover,),
          SizedBox(height: 40.h,),
          Text(
            'Enter your card details',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 40.h,),
          Form(
              child: Column(
                children: [
                  CustomTextForm(
                    label: 'Card Number',
                    suffixIcon: Image.asset(
                      'assets/images/profile_images/mastercard.png',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card number';
                      }else if(value.length != 16){
                        return 'Card number must be 16 digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h,),
                  CustomTextForm(
                    label: 'Card Holder Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextForm(
                          label: 'Expire Date',
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter expire date';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 20.w,),
                      Expanded(
                        child: CustomTextForm(
                          label: 'CVV',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter CVV';
                            }else if(value.length != 3){
                              return 'CVV must be 3 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),


                ],
              ),
          ),
          SizedBox(height: 80.h,),
          ///Button to Save Card
          ///Elevated Button -> Save Card
          ElevatedButton(
            onPressed: () {
              // Handle save card action
              // You can add your logic here to save the card details
              // Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(

              backgroundColor: Theme.of(context).secondaryHeaderColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            child: Text(
              'Save Card',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

    );
  }
}
