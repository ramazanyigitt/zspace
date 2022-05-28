import 'package:equatable/equatable.dart';
import '../../data/enums/creature_types.dart';

class Level extends Equatable {
  Level({
    this.level,
    this.episodeId,
    this.creatureTypes,
  });

  final int? level;
  final int? episodeId;
  final List<CreatureType>? creatureTypes;

  @override
  List<Object?> get props => [
        level,
        episodeId,
        creatureTypes,
      ];
}
