import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreNotesDataSource {
  final FirebaseFirestore firestore;

  FirestoreNotesDataSource(this.firestore);

  Future<void> addNote(String userId, String title, String description) async {
    try {
      // Generate a new document reference with an ID
      final noteRef =
          firestore.collection('users').doc(userId).collection('notes').doc();

      await noteRef.set({
        'noteId': noteRef.id,
        'title': title,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  Future<void> deleteNote(String userId, String noteId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('notes')
          .doc(noteId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getNotes(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
