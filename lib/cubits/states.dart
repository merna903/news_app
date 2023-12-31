abstract class NewsStates {}

class NewsInitialState extends NewsStates{}

class NewsChangeBottomNabBarState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}

class NewsGetBusinessLeadingState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates
{
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsSuccessState extends NewsStates{}

class NewsGetSportsLeadingState extends NewsStates{}

class NewsGetSportsErrorState extends NewsStates
{
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceSuccessState extends NewsStates{}

class NewsGetScienceLeadingState extends NewsStates{}

class NewsGetScienceErrorState extends NewsStates
{
  final String error;

  NewsGetScienceErrorState(this.error);
}


class NewsGetSearchSuccessState extends NewsStates{}

class NewsGetSearchLeadingState extends NewsStates{}

class NewsGetSearchErrorState extends NewsStates
{
  final String error;

  NewsGetSearchErrorState(this.error);
}