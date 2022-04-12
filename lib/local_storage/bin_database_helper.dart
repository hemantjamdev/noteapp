import 'package:hive/hive.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:noteapp/widgets/toast.dart';

class BinHelper {
// delete selected item from archive
  static deleteSelected(NotesModel note) async {
    var box = await Hive.openBox<NotesModel>(Strings.binDbName);
    box.delete(note.id!);
  }

//restore selected item
  static void restoreSelected(NotesModel note) async {
    var binBox = await Hive.openBox<NotesModel>(Strings.dbName);
    binBox.put(note.id!, note);

    var box = await Hive.openBox<NotesModel>(Strings.binDbName);
    box.delete(note.id);
  }

  //delete whole archive database from archive screen
  static deleteAll() async {
    var box = await Hive.openBox<NotesModel>(Strings.binDbName);
    if (box.isNotEmpty) {
      box.deleteAll(box.keys);
    } else {
      toast(Strings.binIsEmpty);
    }
  }
}
