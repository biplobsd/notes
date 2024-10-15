import 'package:either_dart/either.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/layers/domain/repositories/auth_repository.dart';

class SignOutUsecase {
  final AuthRepository repository;

  SignOutUsecase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
