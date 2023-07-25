import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/cubit.dart';
import 'package:news_app/cubits/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (BuildContext context, state)
      {
        var article = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (String value)
                  {
                    print(value);
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  text: 'Search',
                  prefix: Icons.search,
                  context: context,
                ),
              ),
              Expanded(child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder:(context,index) => buildArticleItem(NewsCubit.get(context).search[index],context),
                  separatorBuilder: (context,index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
                  itemCount: NewsCubit.get(context).search.length
                )
              )
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state)
      {

      },
    );
  }
}
