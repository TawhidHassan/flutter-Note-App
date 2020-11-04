import 'package:flutter_note_app/models/notes_model.dart';

class NotesServices{

  List<NotesModel> _notes =
  [
    {
      "id":1,
      "title":'hello worlds',
      "createdAt":"abc"
    }
  ];

  List<NotesModel> get getNotes =>_notes;




}