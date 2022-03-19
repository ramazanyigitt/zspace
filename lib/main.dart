import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'objects/moveable/ships/test5.dart';
import 'objects/moveable/ships/user_ship.dart';

void main() {
  runApp(GameWidget(game: JoystickExample()));
}

class JoystickExample extends FlameGame
    with HasDraggables, HasTappables, HasCollidables {
  late final ShipPlayer player;
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
    player = ShipPlayer(joystick);

    var spriteSheet = await images.load('ninja_boy_glide_ss.png');
    SpriteAnimationData animationData = SpriteAnimationData.sequenced(
      amount: 10,
      stepTime: 0.05,
      textureSize: Vector2(1500 / 10, 150.0),
    );
    var ship = UserShip(
      spriteSheet,
      size: Vector2(150, 150),
      animationData: animationData,
      position: Vector2(200, 150),
      anchor: Anchor.center,
    );

    add(player);
  }
}
