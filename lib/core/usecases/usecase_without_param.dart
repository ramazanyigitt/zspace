import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

abstract class UseCaseWithOutParam<Type> {
  Future<Either<Failure, Type>> call();
}
