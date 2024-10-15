import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/layers/data/data_sources/firestore_notes_datasource.dart';
import 'package:notes/layers/data/repositories_impl/notes_repository_impl.dart';
import 'package:notes/layers/domain/use_cases/add_note_usecase.dart';
import 'package:notes/layers/domain/use_cases/delete_note_usecase.dart';
import 'package:notes/layers/domain/use_cases/get_notes_usecase.dart';
import 'package:notes/layers/domain/use_cases/update_note_usecase.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final notesDataSourceProvider = Provider((ref) {
  return FirestoreNotesDataSource(ref.read(firestoreProvider));
});

final notesRepositoryProvider = Provider((ref) {
  return NotesRepositoryImpl(ref.read(notesDataSourceProvider));
});

final addNoteUseCaseProvider = Provider((ref) {
  return AddNoteUseCase(ref.read(notesRepositoryProvider));
});

final updateNoteUseCaseProvider = Provider((ref) {
  return UpdateNoteUseCase(ref.read(notesRepositoryProvider));
});

final deleteNoteUseCaseProvider = Provider((ref) {
  return DeleteNoteUseCase(ref.read(notesRepositoryProvider));
});

final getNotesUseCaseProvider = Provider((ref) {
  return GetNotesUseCase(ref.read(notesRepositoryProvider));
});
