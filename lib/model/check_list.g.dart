// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckList _$CheckListFromJson(Map<String, dynamic> json) => CheckList(
      json['id'] as int?,
      json['designation'] as String,
      json['completed'] as bool,
      DateTime.parse(json['dateCreation'] as String),
    );

Map<String, dynamic> _$CheckListToJson(CheckList instance) => <String, dynamic>{
      'id': instance.id,
      'designation': instance.designation,
      'completed': instance.completed,
      'dateCreation': instance.dateCreation.toIso8601String(),
    };
