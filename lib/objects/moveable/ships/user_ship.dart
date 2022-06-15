import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:zspace/features/game/_services/igame_service.dart';
import 'package:zspace/injection_container.dart';
import 'package:zspace/objects/creature_object.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/moveable/lasers/red_laser.dart';
import 'package:zspace/objects/moveable/rockets/short_rocket.dart';
import '../../../features/game/gameplay/game_page.dart';
import 'ship.dart';
import 'dart:ui' as ui;

class UserShip extends Ship with CreatureObject {
  /// Pixels/s
  double maxSpeed = 300.0;

  final JoystickComponent joystick;
  final ui.Image image;
  final Vector2 shipSize;
  final Vector2 textureSize;
  final int spriteAmount;
  final double stepTime;
  final bool loop;

  UserShip({
    required this.image,
    required this.joystick,
    required this.shipSize,
    required this.textureSize,
    this.spriteAmount: 1,
    this.stepTime: 0.1,
    List<Vector2>? hitBox,
    this.loop: false,
    bool playing: false,
  }) : super(
          image: image,
          size: shipSize,
          animationData: SpriteAnimationData.sequenced(
            amount: spriteAmount,
            stepTime: stepTime,
            textureSize: textureSize,
            loop: loop,
          ),
          hitBox: hitBox,
          playing: playing,
        ) {
    anchor = Anchor.center;

    if (this.hitBox == null)
      this.hitBox = [
        Vector2(-1, -1),
        Vector2(-1, 1),
        Vector2(1, 1),
        Vector2(1, -1),
      ];
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    setArmor(200);
    setShield(200);
    position = gameRef.size / 2;

    //attackNearestTargetRocket(
    //    duration: Duration(seconds: 1, milliseconds: 800));
  }

  @override
  void onDie() {
    super.onDie();
    (gameRef as GamePage).viewModel.gameOver();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!joystick.delta.isZero()) {
      if (!moving) {
        moving = true;
        lastMoveKey = UniqueKey().toString();
      }
      //log('Moving as ${joystick.relativeDelta * maxSpeed * dt}');
      position.add(joystick.relativeDelta * maxSpeed * dt);
      if (keepAngle != true) {
        angle = joystick.delta.screenAngle();
      }
    } else {
      if (moving) {
        moving = false;
        lastMoveKey = UniqueKey().toString();
      }

      final _lastMoveKey = lastMoveKey;
      attackNearestTarget(lastKey: _lastMoveKey);
    }
  }

  void rotateToEnemy(GameObject enemy) {
    final enemyPosition = enemy.position;
    final myPosition = position;
    final angle = (enemyPosition - myPosition).screenAngle();
    this.angle = angle;
  }

  Future<GameObject?> findTarget() async {
    GameObject? _enemy;
    try {
      final component = gameRef.children
          .firstWhere((value) => value is Ship && !(value is UserShip));
      _enemy = component as Ship;
    } catch (e) {}

    return _enemy;
  }

  @override
  void render(ui.Canvas canvas) {
    super.render(canvas);
    //renderDebugMode(canvas);
  }
}
