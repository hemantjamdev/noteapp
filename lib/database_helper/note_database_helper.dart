import 'package:hive/hive.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/toast.dart';

class Helper {
  ///hive delete multiple selected
  static multipleSelectedDelete(NotesModel note) async {
    // add note in bin database
    var binBox = await Hive.openBox<NotesModel>(Strings.binDbName);
    binBox.put(int.parse(note.id!), note);

    // delete from actual database
    var box = await Hive.openBox<NotesModel>(Strings.dbName);
    box.delete(int.parse(note.id!)).then((value) => toast(Strings.noteDeleted));
  }

  ///add new note
  static void addNewNote(
      {required String title, required String content}) async {
    String _id = (DateTime.now().year.toString() +
            DateTime.now().hour.toString() +
            DateTime.now().minute.toString() +
            DateTime.now().second.toString())
        .toString();

    NotesModel item = NotesModel(
        id: _id, title: title, content: content, createdon: DateTime.now());
    var box = await Hive.openBox<NotesModel>(Strings.dbName);

    box.put(int.parse(_id), item).then((value) => toast(Strings.newNoteAdded));
  }

  /// delete single note from add screen
  static void deleteSingleNote({required NotesModel note}) async {
    // add note in bin database
    var binBox = await Hive.openBox<NotesModel>(Strings.binDbName);
    binBox.put(int.parse(note.id!), note);

    // delete from actual database
    var box = await Hive.openBox<NotesModel>(Strings.dbName);
    box.delete(int.parse(note.id!)).then((value) => toast(Strings.noteDeleted));
  }

  /// hive update note from add screen
  static void noteUpdate(
      {required String id,
      required String title,
      required String content}) async {
    NotesModel item = NotesModel(
        id: id, title: title, content: content, createdon: DateTime.now());
    var box = await Hive.openBox<NotesModel>(Strings.dbName);
    box.put(int.parse(id), item).then((value) => toast(Strings.noteUpdated));
  }
}
