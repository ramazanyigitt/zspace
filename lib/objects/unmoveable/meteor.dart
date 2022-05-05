import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:zspace/objects/game_object.dart';

abstract class Meteor extends GameObject {
  List<Vector2>? hitBox;
  Meteor(
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
  double _explosionRadius = 0;

  set speed(double speed) {
    _speed = speed;
  }

  set damage(double damage) {
    _damage = damage;
  }

  set explosionRadius(double explosionRadius) {
    _explosionRadius = explosionRadius;
  }

  // ignore: unnecessary_getters_setters
  double get speed => _speed;
  // ignore: unnecessary_getters_setters
  double get damage => _damage;
  // ignore: unnecessary_getters_setters
  double get explosionRadius => _explosionRadius;
}
