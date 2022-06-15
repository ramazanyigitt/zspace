import 'dart:ui' as ui;

import 'package:flame/components.dart';

import '../../game_object.dart';

abstract class Rocket extends GameObject {
  GameObject target;
  GameObject shooter;
  Rocket({
    required this.shooter,
    required this.target,
    ui.Image? image,
    SpriteAnimationData? animationData,
    Vector2? position,
    Vector2? size,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super(
          image: image,
          animationData: animationData,
          position: position,
          size: size,
          angle: angle,
          anchor: anchor,
        );

  double _speed = 300;
  double _damage = 0;

  double getSpeed() => _speed;
  double getDamage() => _damage;
  void setSpeed(double speed) {
    _speed = speed;
  }

  void setDamage(double damage) {
    _damage = damage;
  }
}
