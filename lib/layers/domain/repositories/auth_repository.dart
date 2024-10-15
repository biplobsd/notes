import 'package:either_dart/either.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/layers/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signIn(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, User>> register(
      String email, String password, String name);
}
