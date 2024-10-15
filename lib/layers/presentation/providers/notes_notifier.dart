import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/layers/domain/use_cases/add_note_usecase.dart';
import 'package:notes/layers/domain/use_cases/get_notes_usecase.dart';
import 'package:notes/layers/presentation/providers/notes_usecases_providers.dart';
import 'notes_state.dart';

class NotesNotifier extends StateNotifier<NotesState> {
  final AddNoteUseCase _addNoteUseCase;
  final GetNotesUseCase _getNotesUseCase;

  NotesNotifier(this._addNoteUseCase, this._getNotesUseCase)
      : super(const NotesState());

  Future<void> addNote(String userId, String title, String description) async {
    state = state.copyWith(isLoading: true);
    try {
      await _addNoteUseCase(userId, title, description);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void fetchNotes(String userId) {
    state = state.copyWith(isLoading: true);
    _getNotesUseCase(userId).listen((notes) {
      state = state.copyWith(isLoading: false, notes: notes);
    }, onError: (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    });
  }
}

final notesProvider = StateNotifierProvider<NotesNotifier, NotesState>((ref) {
  final addNoteUseCase = ref.read(addNoteUseCaseProvider);
  final getNotesUseCase = ref.read(getNotesUseCaseProvider);
  return NotesNotifier(addNoteUseCase, getNotesUseCase);
});
