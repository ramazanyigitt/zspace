import 'package:flame/game.dart';
import 'package:zspace/data/models/spawn_model.dart';
import 'package:zspace/features/game/gameplay/game_page.dart';
import 'package:zspace/objects/game_object.dart';

import '../../../data/enums/creature_types.dart';
import 'ispawn_service.dart';

class SpawnServiceImpl implements SpawnService {
  @override
  Future<void> spawnCreatures<T extends FlameGame>(
    T game,
    List<SpawnModel> spawnModels,
  ) async {
    int i = 0;
    final level = (game as GamePage).viewModel.level;
    for (SpawnModel spawnModel in spawnModels) {
      final creatureObject = await GameObject.create(
        spawnModel.type!,
        game,
        Vector2(level.spawnModels![i].position![0],
            level.spawnModels![i].position![1]),
      );
      creatureObject.priority = -2;
      game.add(creatureObject);
      i++;
    }
    final portalObject = await GameObject.createPortal(
      game,
      Vector2(game.size.x / 2, 0),
    );
    portalObject.priority = -1;
    game.add(portalObject);
  }
}
