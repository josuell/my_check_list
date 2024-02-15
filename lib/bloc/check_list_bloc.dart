import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:my_check_list/model/check_list.dart';
import 'package:my_check_list/service/my_to_do_list_service.dart';
import 'package:provider/provider.dart';

part 'check_list_event.dart';
part 'check_list_state.dart';

class CheckListBloc extends Bloc<CheckListEvent, CheckListState> {
  CheckListBloc() : super(CheckListInitial()) {
    on<CheckListEvent>((event, emit)async {
      await event.action(emit);
    });
  }
}
