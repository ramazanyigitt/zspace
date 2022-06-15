import 'package:get/get.dart';
import 'package:zspace/data/models/spawn_model.dart';
import 'package:zspace/features/game/level_information/level_information_page.dart';

import '../../../data/enums/creature_types.dart';
import '../../../data/models/episode_model.dart';
import '../../../data/models/level_model.dart';
import 'igame_service.dart';
import 'ispawn_service.dart';

class GameServiceImpl implements GameService {
  final SpawnService spawnService;
  GameServiceImpl({
    required this.spawnService,
  });

  @override
  List<SpawnModel> getSpawnModels(LevelModel levelModel) {
    return levelModel.spawnModels ?? [];
  }

  @override
  void goToLevel(LevelModel levelModel, int level) {
    // TODO: implement goToLevel
  }

  @override
  void goToNextLevel(EpisodeModel episode, LevelModel levelModel) {
    Get.off(
      () => LevelInformationPage(
        episode: episode,
        level: episode.levels![levelModel.level!],
      ),
      transition: Transition.noTransition,
      duration: Duration.zero,
    );
  }

  @override
  void goToPreviousLevel(LevelModel levelModel) {
    // TODO: implement goToPreviousLevel
  }
}
