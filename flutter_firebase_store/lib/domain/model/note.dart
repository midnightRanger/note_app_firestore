
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note{
  const factory Note({
  required String? authorId, 
  required String? name,
  required String? content,
  required String? creationDate, 
  required String? lastUpdating,
  required bool status,
  required String category ,
  }) = _Note; 

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json); 
}