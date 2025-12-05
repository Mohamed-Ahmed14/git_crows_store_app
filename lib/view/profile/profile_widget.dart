import 'package:clothing_store/model/profile_model/profile_model.dart';
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileWidget extends StatelessWidget {
  final ProfileModel profileModel;
  const ProfileWidget({required this.profileModel,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 30.h),
      child:Column(
        children: [
          Row(
            children: [
              Container(
                padding:EdgeInsetsDirectional.all(20.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.grey),
                ),
                child: Icon(profileModel.icon,color: Theme.of(context).secondaryHeaderColor,size: 70.r,)
              ),
              SizedBox(width: 50.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profileModel.title,
                      style: Theme.of(context).textTheme.bodySmall,

                    ),
                    if(profileModel.description != '')
                    Text(profileModel.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.grey,
                    ),
                    )
                  ],
                ),
              ),
              IconButton(onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => profileModel.screen,));
              },
                  icon: Icon(Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).secondaryHeaderColor,),)
            ],
          ),
          SizedBox(height: 30.h,),
          Divider(color: Colors.grey,thickness: 2.h,),
        ],
      ),
    );
  }
}
