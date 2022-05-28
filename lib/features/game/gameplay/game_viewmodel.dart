import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/features/game/_services/ispawn_service.dart';
import 'package:zspace/injection_container.dart';

import '../../../data/models/level_model.dart';
import '../../../objects/moveable/ships/user_ship.dart';
import '../../../objects/unmoveable/game_map.dart';
import '../../../shared/app_images.dart';
import '../_services/igame_service.dart';
import 'game_page.dart';

class GameViewModel extends BaseViewModel {
  GamePage game;
  LevelModel level;
  GameViewModel({
    required this.game,
    required this.level,
  });

  late final UserShip player;
  late final JoystickComponent joystick;
  final knobPaint = BasicPalette.blue.withAlpha(200).paint();
  final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();

  Future<void> prepareGame() async {
    //Camera
    game.camera.viewport = FixedResolutionViewport(Vector2(1.sw, 1.sh));

    //Map

    var mapImage = await game.images.load(AppImages.mapEpisode1Level1.gameMap);
    var map = GameMap(mapImage, size: Vector2(738, 1312));
    game.add(map);

    //User
    joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 15,
        paint: knobPaint,
      ),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      anchor: Anchor.center,
      position: Vector2(-5000, -5000),
      size: 15,
    );

    var userShipImage = await game.images.load(AppImages.ships.vengeanceShip);
    player = UserShip(
      image: userShipImage,
      joystick: joystick,
      shipSize: Vector2(128.0, 128.0),
      textureSize: Vector2(550.0, 648.0),
      spriteAmount: 1,
      playing: true,

      //loop: true,
    );

    //Camera set up
    game.camera.speed = 1;
    game.camera.followComponent(player,
        worldBounds: map.bounds, relativeOffset: Anchor.center);

    game.add(player);
    game.add(joystick);

    locator<GameService>().spawnService.spawnCreatures(
          game,
          locator<GameService>().getCreatures(level),
        );
  }
}
