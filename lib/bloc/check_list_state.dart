part of 'check_list_bloc.dart';

@immutable
abstract class CheckListState {}

class CheckListInitial extends CheckListState {}

class ShowCheckListState extends CheckListState{
  final List<CheckList> theCheckList;

  ShowCheckListState(this.theCheckList);
}

class CheckError extends CheckListState {
  final  String message;

  CheckError(this.message);
}

class UpdateCheckSuccess extends CheckListState{
  final String message;

  UpdateCheckSuccess(this.message);

}
class AddCheckSuccess extends CheckListState{
  final String message;

  AddCheckSuccess(this.message);

}
class DeleteTaskSuccess extends CheckListState{
  final String message;

  DeleteTaskSuccess(this.message);

}
class LoadingState extends CheckListState{

  LoadingState();
}