import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/user.dart';

abstract class DataRepository {
  Future<Either<Failure, User>> getUser();
}
