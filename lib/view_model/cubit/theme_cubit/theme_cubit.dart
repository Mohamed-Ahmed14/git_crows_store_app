import 'package:clothing_store/view_model/cubit/theme_cubit/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitState());

  static ThemeCubit get(context)=>BlocProvider.of<ThemeCubit>(context);

  bool isLightTheme = true;

  void toggleTheme() {
    isLightTheme = !isLightTheme;
    emit(ChangeThemeState());
  }
}