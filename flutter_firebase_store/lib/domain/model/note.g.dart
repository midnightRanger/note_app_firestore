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
      image: Image.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'authorId': instance.authorId,
      'name': instance.name,
      'content': instance.content,
      'creationDate': instance.creationDate,
      'lastUpdating': instance.lastUpdating,
      'status': instance.status,
      'category': instance.category,
      'image': instance.image.toJson(),
    };

_$_Image _$$_ImageFromJson(Map<String, dynamic> json) => _$_Image(
      url: json['url'] as String?,
      name: json['name'] as String?,
      size: json['size'] as int,
    );

Map<String, dynamic> _$$_ImageToJson(_$_Image instance) => <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'size': instance.size,
    };
