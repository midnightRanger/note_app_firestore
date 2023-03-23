import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'category.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note{
  const factory Note({
  required String? authorId, 
  required String? name,
  required String? content,
  required DateTime creationDate, 
  required DateTime lastUpdating,
  required bool status, 
  required Category category 
  }) = _Note; 

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json); 
}