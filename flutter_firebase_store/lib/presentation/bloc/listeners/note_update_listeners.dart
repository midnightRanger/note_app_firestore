import '../../../domain/model/note.dart';

abstract class NoteUpdateListeners { 
  successUpdated();  
  failed(); 
  note(Note? note);
}