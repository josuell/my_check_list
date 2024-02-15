part of 'check_list_bloc.dart';

@immutable
abstract class CheckListEvent {
  Future<void> action(emit);
  final BuildContext context;

  const CheckListEvent(this.context);
}

class ShowingTheCheckListEvent extends CheckListEvent{
  const ShowingTheCheckListEvent(super.context);

  @override
  Future<void> action(emit) async{
    try{
      emit(LoadingState());
      List<CheckList> allCheckList = await context.read<MyToDoListService>().getListTodo();
      emit(ShowCheckListState(allCheckList));
    }catch(e){
      emit(CheckError(e.toString()));
    }
  }

}

class UpdateATodoEvent extends CheckListEvent{
  final CheckList oneTodo;

  const UpdateATodoEvent(super.context,this.oneTodo) ;

  @override
  Future<void> action(emit) async{
    try{
      emit(LoadingState());
      await context.read<MyToDoListService>().updateATodo(oneTodo);
      emit(UpdateCheckSuccess("The todo is update"));
    }catch(e){
      emit(CheckError(e.toString()));
    }
  }

}

class AddATaskEvent extends CheckListEvent{
  final String designation;

  const AddATaskEvent(super.context,this.designation);

  @override
  Future<void> action(emit) async{
    try{
      emit(LoadingState());
      await context.read<MyToDoListService>().createTask(designation);
      emit(AddCheckSuccess("The task is add successfully"));
    }catch(e){
      emit(CheckError(e.toString()));
    }
  }

}

class DeleteOneTaskEvent extends CheckListEvent{
  final CheckList task;

  const DeleteOneTaskEvent(super.context,this.task);

  @override
  Future<void> action(emit) async {
    try{
      emit(LoadingState());
      await context.read<MyToDoListService>().deleteOneTodo(task.id!);
      emit(DeleteTaskSuccess('The task ${task.designation} has been deleted'));
    }catch(e){
      emit(CheckError(e.toString()));
    }
  }

}