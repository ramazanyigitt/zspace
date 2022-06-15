import 'dart:ui' as ui;

import 'package:flame/components.dart';
import '../../game_object.dart';

abstract class Explosion extends GameObject {
  List<Vector2>? hitBox;
  double? damage;
  Explosion({
    ui.Image? image,
    SpriteAnimationData? animationData,
    Vector2? position,
    Vector2? size,
    double? angle,
    Anchor? anchor,
    int? priority,
    this.damage,
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

  void setDamage(double damage) {
    _damage = damage;
  }

  double getDamage() => _damage;
}
