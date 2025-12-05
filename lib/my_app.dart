import 'package:clothing_store/view/auth/login_screen.dart';
import 'package:clothing_store/view/layout/layout_screen.dart';
import 'package:clothing_store/view_model/cubit/auth_cubit/auth_cubit.dart';
import 'package:clothing_store/view_model/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:clothing_store/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:clothing_store/view_model/cubit/layout_cubit/layout_cubit.dart';
import 'package:clothing_store/view_model/cubit/order_cubit/order_cubit.dart';
import 'package:clothing_store/view_model/cubit/profile_cubit/profile_cubit.dart';
import 'package:clothing_store/view_model/cubit/search_cubit/search_cubit.dart';
import 'package:clothing_store/view_model/cubit/theme_cubit/theme_cubit.dart';
import 'package:clothing_store/view_model/cubit/theme_cubit/theme_state.dart';
import 'package:clothing_store/view_model/themes/dark_theme.dart';
import 'package:clothing_store/view_model/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var client = Supabase.instance.client;
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),//1080,1920
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_,child){
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit(),),
            BlocProvider(create: (context) => LayoutCubit(),),
            BlocProvider(create: (context) => HomeCubit(),),
            BlocProvider(create: (context) => FavoriteCubit(),),
            BlocProvider(create: (context) => ProfileCubit(),),
            BlocProvider(create: (context) => SearchCubit(),),
            BlocProvider(create: (context) => OrderCubit(),),
            BlocProvider(create: (context) => ThemeCubit(),)
          ],
          child: BlocBuilder<ThemeCubit,ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Crows Store',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeCubit.get(context).isLightTheme ? ThemeMode.light : ThemeMode.dark,
                home: child,
              );
            },
          ),
        );
      },
      child:(client.auth.currentUser != null)? LayoutScreen():LoginScreen(),
    );
  }
}
