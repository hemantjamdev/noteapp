import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note/model/note_model.dart';
import 'package:note/repository/note_repository.dart';

part 'note_list_cubit.freezed.dart';
part 'note_list_state.dart';

class NoteListCubit extends Cubit<NoteListState> {
  NoteListCubit({required NoteRepository noteRepository})
      : _repository = noteRepository,
        super(NoteListState());

  late NoteRepository _repository;

  getAllNotes() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    try {
      final data = await _repository.getAll();
      List<NoteModel> noteList = [];

      if (data != null) {
        data.forEach((element) {
          noteList.add(element);
        });
      }

      emit(state.copyWith(
        isLoading: false,
        notes: noteList,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  deleteNote() {
    _repository.deleteAll();
    getAllNotes();
  }

  search(String value) async {
    try {
      final data = await _repository.getAll();
      List<NoteModel> noteList = List.from(state.notes);

      if (value.isNotEmpty && data != null) {
        List<NoteModel> filteredNotes = data
            .where((element) {
              return element.filter(value);
            })
            .toList()
            .where((e) => !e.isPrivate)
            .toList();

        emit(state.copyWith(
          isLoading: false,
          notes: filteredNotes,
        ));
      } else {
        noteList = await getAllNoteList() ?? [];
        emit(state.copyWith(
          isLoading: false,
          notes: noteList,
        ));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<List<NoteModel>?> getAllNoteList() async {
    return await _repository.getAll();
  }
// onPinned(NoteModel note) {
//   note = note.copyWith(isPinned: !note.isPinned);
//   _repository.update(note);
//   getAllNotes();
// }
//
// onPrivate(NoteModel note) {
//   note = note.copyWith(isPrivate: !note.isPrivate);
//   _repository.update(note);
//   getAllNotes();
// }
}
