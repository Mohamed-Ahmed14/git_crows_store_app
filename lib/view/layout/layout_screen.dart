import 'package:clothing_store/view_model/cubit/layout_cubit/layout_cubit.dart';
import 'package:clothing_store/view_model/cubit/layout_cubit/layout_state.dart';
import 'package:clothing_store/view_model/utilities/colors.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit,LayoutState>(
      buildWhen: (previous, current) {
        return current is LayoutChangeState;
      },
      builder: (context, state) {
        return Scaffold(
          body: LayoutCubit.get(context).screens[LayoutCubit.get(context).currentIndex],
          //Important to show body behind navbar
          extendBody: true,
          bottomNavigationBar: DotNavigationBar(
              currentIndex: LayoutCubit.get(context).currentIndex,
              onTap: (index){
                LayoutCubit.get(context).setNewIndex(index);
              },
              // (LayoutCubit.get(context).currentIndex == 3)?null:
              selectedItemColor: AppColors.red,
              unselectedItemColor: AppColors.grey,
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              dotIndicatorColor: AppColors.transparent,
              //splashColor: Colors.grey,

              marginR:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
              itemPadding:  EdgeInsets. symmetric(vertical: 30.h, horizontal: 30.w),
              paddingR: EdgeInsetsDirectional.zero,
             // margin: EdgeInsets.all(0.w),

              items: [
                DotNavigationBarItem(icon: Icon(Icons.home_rounded),),
                DotNavigationBarItem(icon: Icon(Icons.search_rounded),),
                DotNavigationBarItem(icon: Icon(Icons.favorite_border_outlined),),
                DotNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),),
                DotNavigationBarItem(icon: Icon(Icons.person),),
              ]),
        );
      },
    );
  }
}
