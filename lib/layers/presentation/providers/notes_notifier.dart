import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/layers/domain/use_cases/add_note_usecase.dart';
import 'package:notes/layers/domain/use_cases/delete_note_usecase.dart';
import 'package:notes/layers/domain/use_cases/get_notes_usecase.dart';
import 'package:notes/layers/domain/use_cases/update_note_usecase.dart';
import 'package:notes/layers/presentation/providers/notes_usecases_providers.dart';
import 'notes_state.dart';

class NotesNotifier extends StateNotifier<NotesState> {
  final AddNoteUseCase _addNoteUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;
  final GetNotesUseCase _getNotesUseCase;

  NotesNotifier(
    this._addNoteUseCase,
    this._updateNoteUseCase,
    this._deleteNoteUseCase,
    this._getNotesUseCase,
  ) : super(const NotesState());

  Future<void> addNote(String userId, String title, String description) async {
    state = state.copyWith(isLoading: true);
    try {
      await _addNoteUseCase(userId, title, description);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateNote(
    String userId,
    String noteId,
    String title,
    String description,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      await _updateNoteUseCase(userId, noteId, title, description);
      // Fetch notes again to reflect the updated note in the state
      fetchNotes(userId);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to update note: $e');
    }
  }

  Future<void> deleteNote(String userId, String noteId) async {
    state = state.copyWith(isLoading: true);
    try {
      await _deleteNoteUseCase(userId, noteId);
      fetchNotes(userId); // Refresh the notes list after deletion
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
  final updateNoteUseCase = ref.read(updateNoteUseCaseProvider);
  final deleteNoteUseCase = ref.read(deleteNoteUseCaseProvider);
  final getNotesUseCase = ref.read(getNotesUseCaseProvider);
  return NotesNotifier(
    addNoteUseCase,
    updateNoteUseCase,
    deleteNoteUseCase,
    getNotesUseCase,
  );
});
