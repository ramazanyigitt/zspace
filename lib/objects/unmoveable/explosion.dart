import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:zspace/objects/game_object.dart';

abstract class Explosion extends GameObject {
  List<Vector2>? hitBox;
  Explosion(
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

  double _explosionMilliseconds = 1000;
  double _damage = 0;
  double _explosionRadius = 0;

  set explosionMilliseconds(double explosionMilliseconds) {
    _explosionMilliseconds = explosionMilliseconds;
  }

  set damage(double damage) {
    _damage = damage;
  }

  set explosionRadius(double explosionRadius) {
    _explosionRadius = explosionRadius;
  }

  // ignore: unnecessary_getters_setters
  double get explosionMilliseconds => _explosionMilliseconds;
  // ignore: unnecessary_getters_setters
  double get damage => _damage;
  // ignore: unnecessary_getters_setters
  double get explosionRadius => _explosionRadius;
}
