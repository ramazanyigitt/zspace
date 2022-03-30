import '../entities/user.dart';

abstract class LocalDataRepository {
  Future<User> getUser();

  Future<void> saveUser(User offerModel);
}
