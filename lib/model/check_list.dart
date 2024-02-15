import 'package:json_annotation/json_annotation.dart';

part 'check_list.g.dart';
@JsonSerializable()
class CheckList{
  int? id;
  String designation;
  bool completed;
  DateTime dateCreation;

  CheckList(this.id, this.designation, this.completed, this.dateCreation);

  factory CheckList.fromJson(Map<String, dynamic> json) => _$CheckListFromJson(json);

  Map<String, dynamic> toJson() => _$CheckListToJson(this);
}