import 'package:notes/layers/domain/repositories/notes_repository.dart';

class GetNotesUseCase {
  final NotesRepository repository;

  GetNotesUseCase(this.repository);

  Stream<List<Map<String, dynamic>>> call(String userId) {
    return repository.getNotes(userId);
  }
}
