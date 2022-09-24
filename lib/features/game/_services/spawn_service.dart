import 'dart:developer';

import 'package:flame/game.dart';
import 'package:zspace/data/models/spawn_model.dart';
import 'package:zspace/features/game/gameplay/game_page.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/unmoveable/game_map.dart';
import 'package:zspace/objects/unmoveable/health_bar.dart';

import '../../../data/enums/creature_types.dart';
import 'ispawn_service.dart';

class SpawnServiceImpl implements SpawnService {
  @override
  Future<void> spawnCreatures<T extends FlameGame>(
    T game,
    List<SpawnModel> spawnModels,
  ) async {
    int i = 0;
    game as GamePage;
    final level = game.viewModel.level;
    for (SpawnModel spawnModel in spawnModels) {
      //convert spawnmodel position to percantage of game size
      final creatureObject = await GameObject.create(
        spawnModel.type!,
        game,
        Vector2(level.spawnModels![i].position![0] * game.viewModel.mapSize.x,
            level.spawnModels![i].position![1] * game.viewModel.mapSize.y),
      );
      creatureObject.healthBar = HealthBar(object: creatureObject);
      creatureObject.priority = -2;
      game.add(creatureObject);
      game.add(creatureObject.healthBar!);
      i++;
    }
    final portalObject = await GameObject.createPortal(
      game,
      Vector2(game.viewModel.mapSize.x / 2, 0),
    );
    portalObject.priority = -1;
    game.add(portalObject);
  }
}
