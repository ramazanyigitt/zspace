import 'package:zspace/data/models/user_model.dart';

class UserService {
  UserModel? user;

  UserModel? getUser() {
    return user;
  }

  Future<void> setUser(UserModel user) async {
    this.user = user;
  }
}
