// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      authorId: json['authorId'] as String?,
      name: json['name'] as String?,
      content: json['content'] as String?,
      creationDate: json['creationDate'] as String?,
      lastUpdating: json['lastUpdating'] as String?,
      status: json['status'] as bool,
      category: json['category'] as String,
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'authorId': instance.authorId,
      'name': instance.name,
      'content': instance.content,
      'creationDate': instance.creationDate,
      'lastUpdating': instance.lastUpdating,
      'status': instance.status,
      'category': instance.category,
    };
