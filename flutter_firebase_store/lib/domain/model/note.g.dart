// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      authorId: json['authorId'] as String?,
      name: json['name'] as String?,
      content: json['content'] as String?,
      creationDate: DateTime.parse(json['creationDate'] as String),
      lastUpdating: DateTime.parse(json['lastUpdating'] as String),
      status: json['status'] as bool,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'authorId': instance.authorId,
      'name': instance.name,
      'content': instance.content,
      'creationDate': instance.creationDate.toIso8601String(),
      'lastUpdating': instance.lastUpdating.toIso8601String(),
      'status': instance.status,
      'category': instance.category,
    };