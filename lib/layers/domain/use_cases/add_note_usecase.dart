import 'package:notes/layers/domain/repositories/notes_repository.dart';

class AddNoteUseCase {
  final NotesRepository repository;

  AddNoteUseCase(this.repository);

  Future<void> call(String userId, String title, String description) {
    return repository.addNote(userId, title, description);
  }
}
