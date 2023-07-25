import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/appstates.dart';
import 'package:news_app/shared/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit(): super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  changeAppMode({bool? fromShared})
  {
    isDark = fromShared ?? !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark ).then((value) {
      emit(AppChangeModeState());
    });
  }
}