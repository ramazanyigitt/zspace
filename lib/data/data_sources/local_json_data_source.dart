import 'dart:convert';

import 'package:flutter/services.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';

import '../../core/errors/exception.dart';
import '../../domain/repositories/local_data_repository.dart';

class JsonLocalDataSource implements LocalDataRepository {
  @override
  Future<User> getUser() async {
    final String? jsonString =
        await rootBundle.loadString('test/fixtures/user.json');

    if (jsonString != null) {
      final data = await json.decode(jsonString);
      return Future.value(UserModel.fromJson(data));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveUser(User offerModel) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }
}
