import 'dart:ui' as ui;

import 'package:flame/components.dart';
import '../game_object.dart';

abstract class Station extends GameObject {
  List<Vector2>? hitBox;
  Station({
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

  double _damage = 0;
  double _shield = 0;

  getDamage() => _damage;
  getShield() => _shield;

  setDamage(double damage) {
    _damage = damage;
  }

  setShield(double shield) {
    _shield = shield;
  }
}
