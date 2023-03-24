import '../../../domain/model/note.dart';

abstract class HomeListeners {
  successDeleted(); 
  successRetrieved();  
  failed();
  myNotes(List<Note> notes);
}

