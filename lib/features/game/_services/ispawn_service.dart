import 'package:flame/game.dart';

import '../../../data/enums/creature_types.dart';

abstract class SpawnService {
  Future<void> spawnCreatures<T extends FlameGame>(
      T game, List<CreatureType> creatureTypes);
}
