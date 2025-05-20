import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/failure.dart';

/// Represents the behaviour of a usecase.
///
/// [Type] represents the returned type.
///
/// [Params] represents the parameters given to the usecase, if any.
abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
