import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/app_cubit.dart';
import 'package:news_app/cubits/cubit.dart';
import 'package:news_app/cubits/states.dart';
import 'package:news_app/modules/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(

      builder: (BuildContext context, state)
      {
        var cubit =NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
                'News App'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                navigateTo(context,SearchScreen());
              }, icon: const Icon(
                Icons.search,
              )),
              IconButton(onPressed: (){
                AppCubit.get(context).changeAppMode(fromShared : null);
              },
                  icon: const Icon(Icons.brightness_4_outlined))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItem,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeCurrentIndex(index);
            },
          ),
        );
      },

      listener: (BuildContext context, Object? state)
      {

      },
    );
  }
}
