import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/utilities/colors.dart';

class CheckoutStepsWidget extends StatelessWidget {
  final int stepNum;
  const CheckoutStepsWidget({
    required this.stepNum,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 48.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.location_on,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          Expanded(
              child: Divider(
                thickness: 1,
                color: stepNum>1?Theme.of(context).secondaryHeaderColor:AppColors.grey,
              )),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
            child: Icon(
              Icons.credit_card_rounded,
              color: stepNum>1?Theme.of(context).secondaryHeaderColor:AppColors.grey,
            ),
          ),
          Expanded(
              child: Divider(
                thickness: 1,
                color: stepNum==3?Theme.of(context).secondaryHeaderColor:AppColors.grey,
              )),
          Icon(
            Icons.check_circle_rounded,
            color: stepNum==3?Theme.of(context).secondaryHeaderColor:AppColors.grey,
          ),
        ],
      ),
    );
  }
}