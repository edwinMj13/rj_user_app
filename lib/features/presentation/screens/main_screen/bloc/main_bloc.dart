import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';

import '../../../../../utils/lc.dart';
import '../../../../data/repository/auth_repository.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent,MainState> {
  MainBloc() : super(HomeInitial()) {

  }


}
