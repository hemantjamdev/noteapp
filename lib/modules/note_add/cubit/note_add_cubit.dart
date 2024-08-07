import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/model/color_enum.dart';
import 'package:note/model/note_model.dart';
import 'package:note/repository/note_repository.dart';

part 'note_add_cubit.freezed.dart';
part 'note_add_state.dart';

class NoteAddCubit extends Cubit<NoteAddState> {
  NoteAddCubit({required NoteRepository noteRepository})
      : _repository = noteRepository,
        super(NoteAddState(addNoteNavigate: false));
  late NoteRepository _repository;

  onColorChanged(BackgroundColorEnum color) {
    emit(state.copyWith(selectedColor: color));
  }

  addNote() {
    if (state.title == null || state.description == null) return;
    try {
      final DateTime dateTime = DateTime.now();
      String id = uuid.v1();

      NoteModel note = NoteModel(
        id: id,
        title: state.title,
        description: state.description,
        date: dateTime,
        color: state.selectedColor.getColor(),
      );
      _repository.addNote(note);
      _repository.getAll();
      emit(state.copyWith(addNoteNavigate: true));
    } catch (e) {
      throw e;
    }
  }

  onTitleChanged(String? title) {
    emit(state.copyWith(title: title));
  }

  onDescriptionChanged(String? description) {
    emit(state.copyWith(description: description));
  }
}
