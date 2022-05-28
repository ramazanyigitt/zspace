import 'package:flame/game.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/moveable/ships/tuhit.dart';

import '../../../data/enums/creature_types.dart';
import '../../../objects/moveable/ships/user_ship.dart';
import '../../../shared/app_images.dart';
import 'ispawn_service.dart';

class SpawnServiceImpl implements SpawnService {
  @override
  Future<void> spawnCreatures<T extends FlameGame>(
    T game,
    List<CreatureType> creatureTypes,
  ) async {
    for (CreatureType creature in creatureTypes) {
      final creatureObject = await GameObject.create(creature, game);
      game.add(creatureObject);
    }
  }
}
