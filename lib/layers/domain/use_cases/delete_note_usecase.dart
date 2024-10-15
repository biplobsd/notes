import 'package:notes/layers/domain/repositories/notes_repository.dart';

class DeleteNoteUseCase {
  final NotesRepository repository;

  DeleteNoteUseCase(this.repository);

  Future<void> call(String userId, String noteId) {
    return repository.deleteNote(userId, noteId);
  }
}
