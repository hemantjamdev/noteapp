import 'package:hive/hive.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/toast.dart';
import 'package:uuid/uuid.dart';

class DbHelper {
  //selected notes delete from note list screen
  static multipleSelectedDelete(NotesModel note) async {
    // add note in bin database
    var binBox = await Hive.openBox<NotesModel>(Strings.binDbName);
    binBox.put(note.id, note);

    // delete from actual database
    var box = await Hive.openBox<NotesModel>(Strings.dbName);
    box.delete(note.id);
  }

  // add new note from notes add screen
  static void addNewNote(
      {required String title, required String content}) async {
    Uuid uuid = const Uuid();
    String _id = uuid.v1();

    NotesModel item = NotesModel(
        id: _id, title: title, content: content, createdon: DateTime.now());
    var box = await Hive.openBox<NotesModel>(Strings.dbName);

    box.put(_id, item).then((value) => toast(Strings.newNoteAdded));
  }

  // delete single note from add screen
  static void deleteSingleNote({required NotesModel note}) async {
    // add note in bin database
    var binBox = await Hive.openBox<NotesModel>(Strings.binDbName);
    binBox.put(note.id!, note);

    // delete from actual database
    var box = await Hive.openBox<NotesModel>(Strings.dbName);
    box.delete(note.id!).then((value) => toast(Strings.noteDeleted));
  }

  //update note from add screen
  static void noteUpdate(
      {required String id,
      required String title,
      required String content}) async {
    NotesModel item = NotesModel(
        id: id, title: title, content: content, createdon: DateTime.now());
    var box = await Hive.openBox<NotesModel>(Strings.dbName);
    box.put(id, item).then((value) => toast(Strings.noteUpdated));
  }
}
