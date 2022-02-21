import 'package:flutter/material.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:provider/provider.dart';

class NotesNotifier with ChangeNotifier {
  List<NotesModel> notes = [];
  addNote(NotesModel note) {
    notes.add(note);
    notifyListeners();
  }
}
