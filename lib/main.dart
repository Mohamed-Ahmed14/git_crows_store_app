
import 'package:bloc/bloc.dart';
import 'package:clothing_store/my_app.dart';
import 'package:clothing_store/view_model/cubit/bloc_observer/bloc_observer.dart';
import 'package:clothing_store/view_model/data/network/dio_helper.dart';
import 'package:clothing_store/view_model/utilities/sensitive_data.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://gpwhlmdstkfwogujyxdv.supabase.co',
    anonKey: anonKey,
  );
  DioHelper.init();
  Bloc.observer = MyObserver();
  runApp(MyApp());

}