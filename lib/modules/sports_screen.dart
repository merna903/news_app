import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/cubit.dart';
import 'package:news_app/cubits/states.dart';
import 'package:news_app/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (BuildContext context, state)
      {
        return ConditionalBuilder(condition: state is! NewsGetSportsLeadingState,
            builder:(context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder:(context,index) => buildArticleItem(NewsCubit.get(context).sports[index],context),
                separatorBuilder: (context,index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                itemCount: NewsCubit.get(context).sports.length),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
      listener: (BuildContext context, Object? state)
      {

      },
    );
  }
}