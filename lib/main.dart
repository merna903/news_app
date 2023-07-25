import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/cubits/app_cubit.dart';
import 'package:news_app/cubits/appstates.dart';
import 'package:news_app/cubits/cubit.dart';
import 'package:news_app/cubits/states.dart';
import 'package:news_app/layouts/news_layout.dart';
import 'package:news_app/shared/blocObserver.dart';
import 'package:news_app/shared/components/constans.dart';
import 'package:news_app/shared/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> NewsCubit()..getBusiness()),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(fromShared : isDark))
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        builder: (BuildContext context, state)
        {
          var mode = AppCubit.get(context).isDark;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              focusColor: Colors.black,
              textTheme: const TextTheme(
                  bodyMedium : TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                      color: Colors.black
                  )
              ),
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(
                      color: Colors.black
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,

                  )
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 200.0
              ),
            ),
            darkTheme: ThemeData(
                focusColor: Colors.white,
                scaffoldBackgroundColor: HexColor('333739'),
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                    iconTheme: const IconThemeData(
                        color: Colors.white
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor:HexColor('333739'),
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    backgroundColor: HexColor('333739'),
                    elevation: 0.0,
                    titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )
                ),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 200.0,
                  backgroundColor: HexColor('333739'),
                ),
                textTheme: const TextTheme(
                    bodyMedium : TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                        color: Colors.white
                    )
                )
            ),
            themeMode: mode ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
        listener: (BuildContext context, Object? state)
        {

        },
      ),
    );
  }
}


