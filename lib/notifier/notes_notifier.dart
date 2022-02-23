import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/model/notes_model.dart';

class NotesNotifier with ChangeNotifier {
  List<NotesModel> notes = [];
  List notelist = <NotesModel>[];
  addNote(NotesModel note) {
    notes.add(note);
    notifyListeners();
  }

  updateNote(NotesModel note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    notifyListeners();
  }

  deleteNote(NotesModel note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
  }

  addItem(NotesModel item) async {
    var box = await Hive.openBox<NotesModel>('notes');

    box.add(item);

    notifyListeners();
  }

  

  getItem() async {
    final box = await Hive.openBox<NotesModel>('notes');

    notelist = box.values.toList();

    notifyListeners();
  }
}
