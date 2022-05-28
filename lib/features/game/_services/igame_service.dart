import 'package:zspace/features/game/_services/ispawn_service.dart';

import '../../../../data/enums/creature_types.dart';
import '../../../../data/models/level_model.dart';

abstract class GameService {
  final SpawnService spawnService;
  GameService({
    required this.spawnService,
  });

  List<CreatureType> getCreatures(LevelModel levelModel);

  void goToNextLevel(LevelModel levelModel);

  void goToPreviousLevel(LevelModel levelModel);

  void goToLevel(LevelModel levelModel, int level);
}
