import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note/model/note_model.dart';
import 'package:note/repository/note_repository.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required NoteRepository noteRepository})
      : _noteRepository = noteRepository,
        super(HomeState());
  final NoteRepository _noteRepository;

  indexChanged(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  Future<String> getAllData() async {
    List<String> list = [];
    List<NoteModel>? notes = await _noteRepository.getAll();
    notes?.forEach((e) {
      log("${e.toString()}");
      list.add(e.toString());
    });
    log("=====>${list.toString()}");
    return list.toString();
  }

  deleteAll() {
    _noteRepository.deleteAll();
    _noteRepository.getAll();
  }
}
