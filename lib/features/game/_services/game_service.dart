import '../../../data/enums/creature_types.dart';
import '../../../data/models/level_model.dart';
import 'igame_service.dart';
import 'ispawn_service.dart';

class GameServiceImpl implements GameService {
  final SpawnService spawnService;
  GameServiceImpl({
    required this.spawnService,
  });

  @override
  List<CreatureType> getCreatures(LevelModel levelModel) {
    return levelModel.creatureTypes ?? [];
  }

  @override
  void goToLevel(LevelModel levelModel, int level) {
    // TODO: implement goToLevel
  }

  @override
  void goToNextLevel(LevelModel levelModel) {
    // TODO: implement goToNextLevel
  }

  @override
  void goToPreviousLevel(LevelModel levelModel) {
    // TODO: implement goToPreviousLevel
  }
}
