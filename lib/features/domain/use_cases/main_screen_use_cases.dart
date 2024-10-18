import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/routes/route_names.dart';

import '../../presentation/screens/search_screen/bloc/search_bloc.dart';

class MainScreenUseCases{
  static ValueNotifier<int> intValueNotifier = ValueNotifier(0);
  updateIndex(int index){
    intValueNotifier.value=index;
  }

  static navigateToSearchScreen(BuildContext context){
    context
        .read<SearchBloc>()
        .add(FetchSearchResultEvent(letter: ""));
    Navigator.pushNamed(context,RouteNames.searchScreen);
  }
}