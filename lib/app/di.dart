import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/layers/data/data_sources/firebase_auth_datasource.dart';
import 'package:notes/layers/data/repositories_impl/auth_repository_impl.dart';
import 'package:notes/layers/domain/repositories/auth_repository.dart';
import 'package:notes/layers/domain/use_cases/register_usecase.dart';
import 'package:notes/layers/domain/use_cases/sign_in_usecase.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firebaseAuthDataSourceProvider = Provider<FirebaseAuthDataSource>((ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  return FirebaseAuthDataSource(firebaseAuth);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.read(firebaseAuthDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return SignInUseCase(repository);
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return RegisterUseCase(repository);
});
