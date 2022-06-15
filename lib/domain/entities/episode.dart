import 'package:equatable/equatable.dart';
import 'level.dart';

class Episode extends Equatable {
  final String? name;
  final List<Level>? levels;
  final String? image;

  Episode({
    this.name,
    this.levels,
    this.image,
  });

  @override
  List<Object?> get props => [
        name,
        levels,
        image,
      ];
}
