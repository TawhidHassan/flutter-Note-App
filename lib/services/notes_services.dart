import 'package:flutter_note_app/models/notes_model.dart';

class NotesServices {

  List<NotesModel> _notes = [];

  List<NotesModel> get getNotes => _notes;


  void addNote(String newTitle) {
    final newNote = NotesModel(
        id: DateTime.now().millisecond.toString(),
        title: newTitle,
        createdAt: DateTime.now().toString()
    );

    _notes.add(newNote);
    return;

  }

  void deleteNotes(String noteId){
    _notes.removeWhere((element) => element.id==noteId);
    return;
  }



}