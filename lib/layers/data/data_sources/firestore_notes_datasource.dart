import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreNotesDataSource {
  final FirebaseFirestore firestore;

  FirestoreNotesDataSource(this.firestore);

  Future<void> addNote(String userId, String title, String description) async {
    await firestore.collection('users').doc(userId).collection('notes').add({
      'title': title,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    });
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
