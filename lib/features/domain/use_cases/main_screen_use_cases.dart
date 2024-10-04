import 'package:flutter/cupertino.dart';

class MainScreenUseCases{
  static ValueNotifier<int> intValueNotifier = ValueNotifier(0);
  updateIndex(int index){
    intValueNotifier.value=index;
  }
}