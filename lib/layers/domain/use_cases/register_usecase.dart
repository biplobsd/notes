import 'package:either_dart/either.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/layers/domain/entities/user.dart';
import 'package:notes/layers/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User>> call(
      String email, String password, String name) {
    return repository.register(email, password, name);
  }
}
