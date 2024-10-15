abstract class NotesRepository {
  Future<void> addNote(String userId, String title, String description);
  Future<void> updateNote(
      String userId, String noteId, String title, String description);
  Future<void> deleteNote(String userId, String noteId);
  Stream<List<Map<String, dynamic>>> getNotes(String userId);
}
