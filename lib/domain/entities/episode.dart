import 'package:equatable/equatable.dart';
import 'level.dart';

class Episode extends Equatable {
  final String? name;
  final List<Level>? levels;

  Episode({
    this.name,
    this.levels,
  });

  @override
  List<Object?> get props => [
        name,
        levels,
      ];
}
