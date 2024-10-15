import 'package:either_dart/either.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/layers/data/data_sources/firebase_auth_datasource.dart';
import 'package:notes/layers/domain/entities/user.dart';
import 'package:notes/layers/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, User>> signIn(String email, String password) async {
    try {
      final user = await dataSource.signIn(email, password);
      if (user != null) {
        return Right(User(uid: user.uid, email: email));
      } else {
        return Left(AuthFailure("User not found"));
      }
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register(
      String email, String password, String name) async {
    try {
      final user = await dataSource.register(email, password, name);
      if (user != null) {
        return Right(User(uid: user.uid, email: user.email ?? ''));
      } else {
        return Left(AuthFailure("Registration failed"));
      }
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
