import 'package:zspace/data/models/spawn_model.dart';
import 'package:zspace/features/game/_services/ispawn_service.dart';

import '../../../../data/enums/creature_types.dart';
import '../../../../data/models/level_model.dart';
import '../../../data/models/episode_model.dart';

abstract class GameService {
  final SpawnService spawnService;
  GameService({
    required this.spawnService,
  });

  List<SpawnModel> getSpawnModels(LevelModel levelModel);

  void goToNextLevel(EpisodeModel episode, LevelModel levelModel);

  void goToPreviousLevel(LevelModel levelModel);

  void goToLevel(LevelModel levelModel, int level);
}
