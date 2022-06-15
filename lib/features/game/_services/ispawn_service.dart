import 'package:flame/game.dart';
import 'package:zspace/data/models/spawn_model.dart';

abstract class SpawnService {
  Future<void> spawnCreatures<T extends FlameGame>(
      T game, List<SpawnModel> spawnModels);
}
