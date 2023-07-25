import 'package:flutter/material.dart';
import 'package:news_app/cubits/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/settings_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/components/constans.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit(): super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<Widget> screens =[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomItem =  [
    const BottomNavigationBarItem(icon: Icon(
        Icons.business_center_outlined
    ),label: 'Business',),
    const BottomNavigationBarItem(icon: Icon(
        Icons.sports_basketball
    ),label: 'Sports',),
    const BottomNavigationBarItem(icon: Icon(
        Icons.science_sharp
    ),label: 'Science',),
  ];

  changeCurrentIndex(index)
  {
    currentIndex = index;
    if(index == 1)  getSports();
    else if(index == 2) getScience();
    emit(NewsChangeBottomNabBarState());
  }

  List<dynamic> business =[];

  getBusiness(){
    emit(NewsGetBusinessLeadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'c8e2fcda4eee4b6080c97ad336b588be',
        }).then((value) {
      //print(value.data.toString());
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports =[];

  getSports(){
    emit(NewsGetSportsLeadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sport',
            'apiKey':'c8e2fcda4eee4b6080c97ad336b588be',
          }).then((value) {
        //print(value.data.toString());
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else
      {
        emit(NewsGetSportsSuccessState());
      }
  }

  List<dynamic> science =[];

  getScience(){
    emit(NewsGetScienceLeadingState());
    if (science.isEmpty) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'c8e2fcda4eee4b6080c97ad336b588be',
          }).then((value) {
        //print(value.data.toString());
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else
    {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search =[];

  getSearch(String? key){
    emit(NewsGetSearchLeadingState());
    if(key != null) {
        DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':key,
            'apiKey':'c8e2fcda4eee4b6080c97ad336b588be',
          }).then((value) {
        //print(value.data.toString());
        search = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
    }
  }

}