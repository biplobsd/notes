import 'package:notes/layers/domain/repositories/notes_repository.dart';

class UpdateNoteUseCase {
  final NotesRepository repository;

  UpdateNoteUseCase(this.repository);

  Future<void> call(
      String userId, String noteId, String title, String description) {
    return repository.updateNote(userId, noteId, title, description);
  }
}
