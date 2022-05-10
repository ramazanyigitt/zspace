import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:stacked/stacked.dart';
import 'package:zspace/objects/moveable/ships/user_ship.dart';
import 'package:zspace/objects/unmoveable/game_map.dart';
import 'package:zspace/presentation/screens/game/game_page.dart';
import 'package:zspace/shared/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameViewModel extends BaseViewModel {
  GamePage game;
  GameViewModel({required this.game});

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
      position: Vector2(100, 100),
      size: 15,
    );

    var userShipImage =
        await game.images.load(AppImages.vengeanceShip.gameShip);
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
    game.camera.followComponent(player, worldBounds: map.bounds);

    game.add(player);
    game.add(joystick);
  }
}
