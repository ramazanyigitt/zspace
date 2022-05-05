import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:zspace/objects/moveable/ships/user_ship.dart';
import 'package:zspace/presentation/screens/game/game_viewmodel.dart';

class GamePage extends FlameGame
    with HasDraggables, HasTappables, HasCollidables {
  late final UserShip player;
  late final JoystickComponent joystick;
  final knobPaint = BasicPalette.blue.withAlpha(200).paint();
  final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    joystick.position =
        Vector2(info.eventPosition.global.x, info.eventPosition.global.y);
    add(joystick);
    super.onTapDown(pointerId, info);
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    stopJoystick();
    super.onTapUp(pointerId, info);
  }

  @override
  void onDragStart(int pointerId, DragStartInfo details) {
    joystick.position =
        Vector2(details.eventPosition.global.x, details.eventPosition.global.y);
    super.onDragStart(pointerId, details);
  }

  @override
  void onDragEnd(int pointerId, DragEndInfo details) {
    stopJoystick();
    super.onDragEnd(pointerId, details);
  }

  @override
  void onDragCancel(int pointerId) {
    stopJoystick();
    super.onDragCancel(pointerId);
  }

  stopJoystick() {
    joystick.delta.setZero();
    remove(joystick);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 30,
        paint: knobPaint,
      ),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      position: Vector2(100, 100),
      size: 15,
    );

    var spriteSheet = await images.load('ninja_boy_glide_ss.png');
    var player = UserShip(
      image: spriteSheet,
      joystick: joystick,
      textureSize: Vector2(150.0, 150.0),
      spriteAmount: 10,
    );

    add(player);
  }
}
