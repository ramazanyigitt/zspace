import 'dart:ui' as ui;

import 'package:flame/components.dart';

import '../../game_object.dart';

abstract class Rocket extends GameObject {
  List<Vector2>? hitBox;
  Rocket(
    ui.Image image, {
    SpriteAnimationData? animationData,
    Vector2? position,
    required Vector2 size,
    double? angle,
    Anchor? anchor,
    int? priority,
    this.hitBox,
  }) : super(
          image,
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
