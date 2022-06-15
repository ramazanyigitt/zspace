import 'package:equatable/equatable.dart';
import 'package:zspace/data/models/spawn_model.dart';
import '../../data/enums/creature_types.dart';

class Level extends Equatable {
  Level({
    this.level,
    this.episodeId,
    this.spawnModels,
  });

  final int? level;
  final int? episodeId;
  final List<SpawnModel>? spawnModels;

  @override
  List<Object?> get props => [
        level,
        episodeId,
        spawnModels,
      ];
}
