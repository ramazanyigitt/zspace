import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/moveable/lasers/red_laser.dart';
import 'ship.dart';
import 'dart:ui' as ui;

class UserShip extends Ship {
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

    if (hitBox == null)
      hitBox = [
        Vector2(-1, -1),
        Vector2(-1, 1),
        Vector2(1, 1),
        Vector2(1, -1),
      ];
  }

  late bool _targeting;
  late bool moving;
  late String lastMoveKey;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = gameRef.size / 2;
    _targeting = false;
    moving = false;
    lastMoveKey = '';
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
      attackNearestTarget(_lastMoveKey);
    }
  }

  void attackNearestTarget(String lastKey) async {
    if (lastKey != lastMoveKey) return;
    if (_targeting) return null;
    _targeting = true;
    await Future.delayed(Duration(seconds: 1, milliseconds: 800));
    if (lastKey != lastMoveKey) {
      _targeting = false;
      return;
    }
    final enemy = await findTarget();
    if (enemy == null || moving) {
      _targeting = false;
      return;
    }
    if (lastKey != lastMoveKey) {
      _targeting = false;
      return;
    }
    rotateToEnemy(enemy);
    await shootLaser(enemy);
    _targeting = false;
  }

  void rotateToEnemy(GameObject enemy) {
    final enemyPosition = enemy.position;
    final myPosition = position;
    final angle = (enemyPosition - myPosition).screenAngle();
    this.angle = angle;
  }

  Future<void> shootLaser(GameObject enemy) async {
    final laser =
        await GameObject.createLaser<RedLaser>(this.gameRef, enemy, this);
    this.gameRef.add(laser);
  }

  Future<GameObject?> findTarget() async {
    final component = gameRef.children
        .firstWhere((value) => value is Ship && !(value is UserShip));

    final enemy = component as Ship;
    return enemy;
  }

  @override
  void render(ui.Canvas canvas) {
    super.render(canvas);
    //renderDebugMode(canvas);
  }
}
