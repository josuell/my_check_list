import 'service/my_to_do_list_service.dart';

void main(){

  List<int> ids = [0,4,3,8,2,6,9,5];
  MyToDoListService().sortInt(ids, SortType.asc);
}
