import 'package:notes/layers/data/data_sources/firestore_notes_datasource.dart';
import 'package:notes/layers/domain/repositories/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final FirestoreNotesDataSource dataSource;

  NotesRepositoryImpl(this.dataSource);

  @override
  Future<void> addNote(String userId, String title, String description) {
    return dataSource.addNote(userId, title, description);
  }

  @override
  Future<void> deleteNote(String userId, String noteId) async {
    await dataSource.deleteNote(userId, noteId);
  }

  @override
  Stream<List<Map<String, dynamic>>> getNotes(String userId) {
    return dataSource.getNotes(userId);
  }
}
