import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/objects/moveable/ships/user_ship.dart';
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
    game.add(Map());

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
    game.camera.followComponent(player, worldBounds: Map.bounds);

    await game.add(player);
  }

  isGameFinish() {}

  isPlayerAlive() {}

  routeToLevelInfoPage() {}
}

class Map extends Component {
  static const double size = 1500;
  static const Rect bounds = Rect.fromLTWH(-size, -size, 2 * size, 2 * size);

  static final Paint _paintBorder = Paint()
    ..color = Colors.white12
    ..strokeWidth = 10
    ..style = PaintingStyle.stroke;
  static final Paint _paintBg = Paint()..color = const Color(0xFF333333);

  static final _rng = Random();

  late final List<Paint> _paintPool;
  late final List<Rect> _rectPool;

  Map() : super(priority: 0) {
    _paintPool = List<Paint>.generate(
      (size / 50).ceil(),
      (_) => PaintExtension.random(rng: _rng)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
      growable: false,
    );
    _rectPool = List<Rect>.generate(
      (size / 50).ceil(),
      (i) => Rect.fromCircle(center: Offset.zero, radius: size - i * 50),
      growable: false,
    );
  }

  @override
  void render(Canvas canvas) {
    // canvas.drawImageRect(image, offset, paint)
    canvas.drawRect(bounds, _paintBg);
    canvas.drawRect(bounds, _paintBorder);
    for (var i = 0; i < (size / 50).ceil(); i++) {
      canvas.drawCircle(Offset.zero, size - i * 50, _paintPool[i]);
      canvas.drawRect(_rectPool[i], _paintBorder);
    }
  }

  static double genCoord() {
    return -size + _rng.nextDouble() * (2 * size);
  }
}
