import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import '../../game_object.dart';

abstract class Ship extends GameObject {
  Ship({
    ui.Image? image,
    SpriteAnimationData? animationData,
    Vector2? position,
    Vector2? size,
    double? angle,
    Anchor? anchor,
    int? priority,
    required List<Vector2> hitBox,
    bool playing: false,
  }) : super(
          image: image,
          animationData: animationData,
          position: position,
          size: size,
          angle: angle,
          anchor: anchor,
          hitBox: hitBox,
          playing: playing,
        );

  double _speed = 300;
  double _armor = 100;
  double _maxArmor = 100;
  double _shield = 0;

  getShield() => _shield;
  getArmor() => _armor;
  getMaxArmor() => _maxArmor;
  getSpeed() => _speed;

  setShield(double shield) {
    _shield = shield;
  }

  setArmor(double armor) {
    _armor = armor;
  }

  setMaxArmor(double maxArmor) {
    _maxArmor = maxArmor;
  }

  setSpeed(double speed) {
    _speed = speed;
  }
}
