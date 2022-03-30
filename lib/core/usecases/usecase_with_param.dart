import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

abstract class UseCaseWithParam<Type, Params> {
  Future<Either<Failure, Type>> call(Params? params);
}
