import 'package:hive/hive.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/toast.dart';

class BinHelper {
  ///hive delete multiple selected
  ///hive delete
  static deleteSelected(NotesModel note) async {
    var box = await Hive.openBox<NotesModel>(Strings.binDbName);
    box.delete(int.parse(note.id!));
  }

  /// put back to main database
  static void restoreSelected(NotesModel note) async {
    var binBox = await Hive.openBox<NotesModel>(Strings.dbName);
    binBox.put(int.parse(note.id!), note);

    // delete from bin database
    var box = await Hive.openBox<NotesModel>(Strings.binDbName);
    box.delete(int.parse(note.id!));
  }

  static deleteAll() async {
    var box = await Hive.openBox<NotesModel>(Strings.binDbName);
    if (box.isNotEmpty) {
      box.deleteAll(box.keys);
    } else {
      toast(Strings.binIsEmpty);
    }
  }

  ///add new note
/*  static void addNewNote(
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
  }*/

  /// delete single note from add screen
/*static void deleteSingleNote({required NotesModel note}) async {
    // add note in bin database
    var binBox = await Hive.openBox<NotesModel>(Strings.binDbName);
    binBox.put(int.parse(note.id!), note);

    // delete from actual database
    var box = await Hive.openBox<NotesModel>(Strings.dbName);
    box.delete(int.parse(note.id!)).then((value) => toast(Strings.noteDeleted));
  }*/

  /// hive update note from add screen
/* static void noteUpdate(
      {required String id,
        required String title,
        required String content}) async {
    NotesModel item = NotesModel(
        id: id, title: title, content: content, createdon: DateTime.now());
    var box = await Hive.openBox<NotesModel>(Strings.dbName);
    box.put(int.parse(id), item).then((value) => toast(Strings.noteUpdated));
  }*/
}
