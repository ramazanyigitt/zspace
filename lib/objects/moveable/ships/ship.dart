import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/cupertino.dart';

import '../../game_object.dart';
import '../lasers/red_laser.dart';
import '../rockets/short_rocket.dart';

abstract class Ship extends GameObject {
  Ship({
    ui.Image? image,
    SpriteAnimationData? animationData,
    Vector2? position,
    Vector2? size,
    double? angle,
    Anchor? anchor,
    int? priority,
    List<Vector2>? hitBox,
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

  late bool targeting;
  late bool moving;
  String? lastMoveKey;

  @override
  Future<void> onLoad() async {
    targeting = false;
    moving = false;
    super.onLoad();
  }

  double _speed = 300;
  double _armor = 100;
  double _maxArmor = 100;
  double _shield = 0;

  double getShield() => _shield;
  double getArmor() => _armor;
  double getMaxArmor() => _maxArmor;
  double getSpeed() => _speed;

  void setShield(double shield) {
    _shield = shield;
  }

  void setArmor(double armor) {
    _armor = armor;
  }

  void setMaxArmor(double maxArmor) {
    _maxArmor = maxArmor;
  }

  void setSpeed(double speed) {
    _speed = speed;
  }

  void decreaseShield(double damage) {
    _shield = _shield - damage;
  }

  void decreaseArmor(double damage) {
    _armor = _armor - damage;
    if (_armor <= 0) {
      onDie();
    }
  }

  void getDamageNormal(double damage) {
    if (_shield > 0) {
      decreaseShield(damage / 100 * 60);
      decreaseArmor(damage / 100 * 40);
    } else {
      decreaseArmor(damage);
    }
  }

  void getDamageShield(double damage) {
    if (_shield > 0) {
      decreaseShield(damage);
    }
  }

  void getDamageArmor(double damage) {
    if (_armor > 0) {
      decreaseArmor(damage);
    }
  }

  void onDie() {}
}
