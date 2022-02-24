/*
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';

class NotesNotifier with ChangeNotifier {
  NotesNotifier() {
    getItem();
  }
  List<NotesModel> notes = [];

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
    var box = await Hive.openBox<NotesModel>(Strings.dbName);

    box.add(item);

    notifyListeners();
  }

  getItem() async {
    final box =  Hive.box<NotesModel>(Strings.dbName);
    notes = box.values.toList();
    notifyListeners();
  }
}
*/
