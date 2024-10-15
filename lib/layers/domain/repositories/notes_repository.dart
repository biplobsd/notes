abstract class NotesRepository {
  Future<void> addNote(String userId, String title, String description);
  Stream<List<Map<String, dynamic>>> getNotes(String userId);
}
