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

  final JoystickComponent joystick;
  final ui.Image image;
  final Vector2 shipSize;
  final Vector2 textureSize;
  final int spriteAmount;
  final double stepTime;
  final bool loop;
  final double damage;

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
    double speed: 300,
    double armor: 100,
    double shield: 50,
    required this.damage,
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
    setSpeed(speed);
    setArmor(armor);
    setShield(shield);

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
    position = gameRef.size - size;

    //attackNearestTargetRocket(
    //    duration: Duration(seconds: 1, milliseconds: 800));
  }

  @override
  void onDie() {
    (gameRef as GamePage).viewModel.gameOver();
    super.onDie();
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
      position.add(joystick.relativeDelta * getSpeed() * dt);
      if (keepAngle != true) {
        angle = joystick.delta.screenAngle();
      }
    } else {
      if (moving) {
        moving = false;
        lastMoveKey = UniqueKey().toString();
      }

      final _lastMoveKey = lastMoveKey;
      attackNearestTarget(lastKey: _lastMoveKey, damage: damage);
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
