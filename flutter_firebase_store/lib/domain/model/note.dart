
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note {
  const factory Note({
    required String? authorId,
    required String? name,
    required String? content,
    required String? creationDate,
    required String? lastUpdating,
    required bool status,
    required String category,
    required Image image,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}

@freezed
class Image with _$Image {
  const factory Image({
    required String? url,
    required String? name,
    required int size,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
