part of 'check_list_bloc.dart';

@immutable
abstract class CheckListEvent {
  Future<void> action(emit);
}

class ShowingTheCheckListEvent extends CheckListEvent{
  @override
  Future<void> action(emit) async{
    try{
      List<CheckList> allCheckList = await MyToDoListService().getListTodo();
      emit(ShowCheckListState(allCheckList));
    }catch(e){
      emit(CheckError(e.toString()));
    }
  }

}

class UpdateATodoEvent extends CheckListEvent{
  final CheckList oneTodo;

  UpdateATodoEvent(this.oneTodo);

  @override
  Future<void> action(emit) async{
    try{
      emit(LoadingState());
      await MyToDoListService().updateATodo(oneTodo);
      emit(UpdateCheckSuccess("The todo is update"));
    }catch(e){
      emit(CheckError(e.toString()));
    }
  }

}

class AddATaskEvent extends CheckListEvent{
  final String designation;

  AddATaskEvent(this.designation);

  @override
  Future<void> action(emit) async{
    try{
      emit(LoadingState());
      await MyToDoListService().createTask(designation);
      emit(AddCheckSuccess("The task is add successfully"));
    }catch(e){
      emit(CheckError(e.toString()));
    }
  }

}

class DeleteOneTaskEvent extends CheckListEvent{
  final CheckList task;

  DeleteOneTaskEvent(this.task);

  @override
  Future<void> action(emit) async {
    try{
      emit(LoadingState());
      await MyToDoListService().deleteOneTodo(task.id!);
      emit(DeleteTaskSuccess('The task ${task.designation} has been deleted'));
    }catch(e){
      emit(CheckError(e.toString()));
    }
  }

}