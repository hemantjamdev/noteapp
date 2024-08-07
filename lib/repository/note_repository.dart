import 'package:note/local_storage/local_storage.dart';
import 'package:note/model/note_model.dart';

class NoteRepository {
  DBHelper _dbHelper = DBHelper();

  addNote(NoteModel note) => _dbHelper.addNote(note: note);

  void update(NoteModel note) => _dbHelper.update(note: note);

  void delete(String id) => _dbHelper.delete(id: id);

  void deleteAll() => _dbHelper.deleteAll();

  Future<List<NoteModel>?> getAll() => _dbHelper.getAll();

  Future<NoteModel?> getNoteById(String id) => _dbHelper.getNoteById(id);
}
