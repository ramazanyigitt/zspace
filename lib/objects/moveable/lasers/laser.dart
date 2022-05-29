import 'dart:ui' as ui;

import 'package:flame/components.dart';

import '../../game_object.dart';

abstract class Laser extends GameObject {
  List<Vector2> hitBox;
  Vector2 target;
  GameObject shooter;
  Laser({
    required this.shooter,
    required this.target,
    ui.Image? image,
    SpriteAnimationData? animationData,
    Vector2? position,
    Vector2? size,
    double? angle,
    Anchor? anchor,
    int? priority,
    required this.hitBox,
  }) : super(
          image: image,
          animationData: animationData,
          position: position,
          size: size,
          angle: angle,
          anchor: anchor,
          hitBox: hitBox,
        );

  double _speed = 300;
  double _damage = 0;

  getSpeed() => _speed;
  getDamage() => _damage;
  setSpeed(double speed) {
    _speed = speed;
  }

  setDamage(double damage) {
    _damage = damage;
  }
}
