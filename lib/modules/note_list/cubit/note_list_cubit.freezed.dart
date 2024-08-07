// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NoteListState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<NoteModel> get notes => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NoteListStateCopyWith<NoteListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteListStateCopyWith<$Res> {
  factory $NoteListStateCopyWith(
          NoteListState value, $Res Function(NoteListState) then) =
      _$NoteListStateCopyWithImpl<$Res, NoteListState>;
  @useResult
  $Res call({bool isLoading, List<NoteModel> notes, String? errorMessage});
}

/// @nodoc
class _$NoteListStateCopyWithImpl<$Res, $Val extends NoteListState>
    implements $NoteListStateCopyWith<$Res> {
  _$NoteListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? notes = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_$NoteListStateImplCopyWith<$Res>
    implements $NoteListStateCopyWith<$Res> {
  factory _$$_$NoteListStateImplCopyWith(_$_$NoteListStateImpl value,
          $Res Function(_$_$NoteListStateImpl) then) =
      __$$_$NoteListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<NoteModel> notes, String? errorMessage});
}

/// @nodoc
class __$$_$NoteListStateImplCopyWithImpl<$Res>
    extends _$NoteListStateCopyWithImpl<$Res, _$_$NoteListStateImpl>
    implements _$$_$NoteListStateImplCopyWith<$Res> {
  __$$_$NoteListStateImplCopyWithImpl(
      _$_$NoteListStateImpl _value, $Res Function(_$_$NoteListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? notes = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_$NoteListStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_$NoteListStateImpl implements __$NoteListState {
  const _$_$NoteListStateImpl(
      {this.isLoading = false,
      final List<NoteModel> notes = const [],
      this.errorMessage})
      : _notes = notes;

  @override
  @JsonKey()
  final bool isLoading;
  final List<NoteModel> _notes;
  @override
  @JsonKey()
  List<NoteModel> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'NoteListState(isLoading: $isLoading, notes: $notes, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_$NoteListStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_notes), errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_$NoteListStateImplCopyWith<_$_$NoteListStateImpl> get copyWith =>
      __$$_$NoteListStateImplCopyWithImpl<_$_$NoteListStateImpl>(
          this, _$identity);
}

abstract class __$NoteListState implements NoteListState {
  const factory __$NoteListState(
      {final bool isLoading,
      final List<NoteModel> notes,
      final String? errorMessage}) = _$_$NoteListStateImpl;

  @override
  bool get isLoading;
  @override
  List<NoteModel> get notes;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_$NoteListStateImplCopyWith<_$_$NoteListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
