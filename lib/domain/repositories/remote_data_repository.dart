import '../entities/user.dart';

abstract class RemoteDataRepository {
  Future<User> getUser();
}
