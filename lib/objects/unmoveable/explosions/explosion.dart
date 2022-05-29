import 'dart:ui' as ui;

import 'package:flame/components.dart';
import '../../game_object.dart';

abstract class Explosion extends GameObject {
  List<Vector2> hitBox;
  Explosion({
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

  double _explosionMilliseconds = 1000;
  double _damage = 0;
  double _explosionRadius = 0;

  setExplosionMilliseconds(double explosionMilliseconds) {
    _explosionMilliseconds = explosionMilliseconds;
  }

  setDamage(double damage) {
    _damage = damage;
  }

  setExplosionRadius(double explosionRadius) {
    _explosionRadius = explosionRadius;
  }

  // ignore: unnecessary_getters_setters
  double get explosionMilliseconds => _explosionMilliseconds;
  // ignore: unnecessary_getters_setters
  double get damage => _damage;
  // ignore: unnecessary_getters_setters
  double get explosionRadius => _explosionRadius;
}
