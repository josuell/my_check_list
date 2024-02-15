
import 'package:dio/dio.dart';
import 'package:my_check_list/model/check_list.dart';

enum SortType { asc, desc }

class MyToDoListService {
  late Dio dio;

  MyToDoListService() {
    dio = Dio();
    dio.options.baseUrl = 'http://192.168.88.5:8080';
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        error: true));
    dio.options.headers['Accept'] = 'application/json';
  }

  Future<List<CheckList>> getListTodo(
      {int? page, int? limit, String? idCheck}) async {

    if (idCheck != null) {}
    final res = await dio.get('/todos');
    List<CheckList> checkLists = [];
    for (var check in res.data['_embedded']['todos']) {
      checkLists.add(CheckList.fromJson(check as Map<String, dynamic>));
    }
    return checkLists;
  }

  Future<Response> deleteOneTodo(int idTask) async {
    var todo = await dio.delete('/todos/$idTask');
    return todo;
  }

  Future<Response> updateATodo(CheckList aCheckList) async {
    var todo =
        await dio.put('/todos/${aCheckList.id}', data: aCheckList.toJson());
    return todo;
  }

  Future<Response> createTask(String designation) async {
    CheckList createTask = CheckList(null, designation, false, DateTime.now());
    var todo = await dio.post('/todos', data: createTask.toJson());
    return todo;
  }

  List<int> sortInt(List<int> id, SortType type) {
    for (int index = 0; index < id.length; index++) {
      for (int indexSecond = 0; indexSecond < id.length; indexSecond++) {
        if (type == SortType.asc
            ? id[indexSecond] > id[index]
            : id[indexSecond] < id[index]) {
          int temp = id[index];
          id[index] = id[indexSecond];
          id[indexSecond] = temp;
        }
      }
    }
    return id;
  }

  List<CheckList> sortTaskByDesignation(
      List<CheckList> checkList, SortType type) {
    for (int index = 0; index < checkList.length; index++) {
      for (int indexSecond = 0; indexSecond < checkList.length; indexSecond++) {
        if (type == SortType.asc
            ? checkList[indexSecond]
                    .designation
                    .compareTo(checkList[index].designation) >
                0
            : checkList[indexSecond]
                    .designation
                    .compareTo(checkList[index].designation) <
                0) {
          CheckList temp = checkList[index];
          checkList[index] = checkList[indexSecond];
          checkList[indexSecond] = temp;
        }
      }
    }
    return checkList;
  }

  List<CheckList> sortTaskByDate(List<CheckList> checkList, SortType max) {
    for (int index = 0; index < checkList.length; index++) {
      for (int indexSecond = 0; indexSecond < checkList.length; indexSecond++) {
        if (max == SortType.asc
            ? checkList[indexSecond]
                    .dateCreation
                    .compareTo(checkList[index].dateCreation) >
                0
            : checkList[indexSecond]
                    .dateCreation
                    .compareTo(checkList[index].dateCreation) <
                0) {
          CheckList temp = checkList[index];
          checkList[index] = checkList[indexSecond];
          checkList[indexSecond] = temp;
        }
      }
    }
    return checkList;
  }
}
