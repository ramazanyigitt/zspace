import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zspace/objects/unmoveable/health_bar.dart';
import 'dart:math' as math;
export 'package:zspace/data/enums/creature_types.dart';

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
    this.healthBar,
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
  HealthBar? healthBar;
  String? lastMoveKey;

  @override
  Future<void> onLoad() async {
    targeting = false;
    moving = false;
    super.onLoad();
  }

  double _speed = 300;
  double _armor = 100;
  double _shield = 0;
  double _maxArmor = 100;
  double _maxShield = 0;

  double getMaxShield() => _maxShield;
  double getMaxArmor() => _maxArmor;
  double getShield() => _shield;
  double getArmor() => _armor;
  double getSpeed() => _speed;

  //create stream controller
  StreamController<double> _armorController = StreamController<double>();
  StreamController<double> _shieldController = StreamController<double>();
  StreamController<double> _speedController = StreamController<double>();
  StreamController<double> _maxArmorController = StreamController<double>();
  StreamController<double> _maxShieldController = StreamController<double>();

  Stream<double> getArmorStream() => _armorController.stream;
  Stream<double> getShieldStream() => _shieldController.stream;
  Stream<double> getSpeedStream() => _speedController.stream;
  Stream<double> getMaxArmorStream() => _maxArmorController.stream;
  Stream<double> getMaxShieldStream() => _maxShieldController.stream;

  Widget onArmorChanged(Widget Function(BuildContext, double) builder) {
    return StreamBuilder<double>(
      stream: getArmorStream(),
      builder: (context, snapshot) {
        return builder(context, snapshot.data ?? 0);
      },
    );
  }

  Widget onShieldChanged(Widget Function(BuildContext, double) builder) {
    return StreamBuilder<double>(
      stream: getShieldStream(),
      builder: (context, snapshot) {
        return builder(context, snapshot.data ?? 0);
      },
    );
  }

  Widget onSpeedChanged(Widget Function(BuildContext, double) builder) {
    return StreamBuilder<double>(
      stream: getSpeedStream(),
      builder: (context, snapshot) {
        return builder(context, snapshot.data ?? 0);
      },
    );
  }

  Widget onMaxArmorChanged(Widget Function(BuildContext, double) builder) {
    return StreamBuilder<double>(
      stream: getMaxArmorStream(),
      builder: (context, snapshot) {
        return builder(context, snapshot.data ?? 0);
      },
    );
  }

  Widget onMaxShieldChanged(Widget Function(BuildContext, double) builder) {
    return StreamBuilder<double>(
      stream: getMaxShieldStream(),
      builder: (context, snapshot) {
        return builder(context, snapshot.data ?? 0);
      },
    );
  }

  void setShield(double shield) {
    _maxShield = shield;
    _shield = shield;

    _shieldController.add(_shield);
  }

  void setArmor(double armor) {
    _maxArmor = armor;
    _armor = armor;

    _armorController.add(_armor);
  }

  void setSpeed(double speed) {
    _speed = speed;

    _speedController.add(_speed);
  }

  void decreaseShield(double damage) {
    _shield = _shield - damage;

    _shieldController.add(_shield);
  }

  void decreaseArmor(double damage) {
    _armor = _armor - damage;
    if (_armor <= 0) {
      onDie();
    } else {
      _armorController.add(_armor);
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

  void closeStreams() {
    _armorController.close();
    _shieldController.close();
    _speedController.close();
    _maxArmorController.close();
    _maxShieldController.close();
  }

  @mustCallSuper
  void onDie() {
    if (healthBar != null) this.gameRef.remove(healthBar!);
    this.gameRef.remove(this);
    this.removeFromParent();
    closeStreams();
  }

  @override
  void render(Canvas canvas) async {
    super.render(canvas);
  }
}
