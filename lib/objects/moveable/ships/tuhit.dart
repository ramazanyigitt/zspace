import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:zspace/objects/creature_object.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/moveable/lasers/red_laser.dart';
import 'ship.dart';
import 'dart:ui' as ui;

class TuhitShip extends Ship with CreatureObject implements GameObject {
  TuhitShip({
    ui.Image? image,
    Vector2? shipSize,
    Vector2? textureSize,
    int spriteAmount: 1,
    double stepTime: 0.1,
    required List<Vector2> hitBox,
    bool loop: false,
    bool playing: false,
    Vector2? position,
  }) : super(
          image: image,
          size: shipSize,
          animationData: SpriteAnimationData.sequenced(
            amount: spriteAmount,
            stepTime: stepTime,
            textureSize: textureSize ?? Vector2.zero(),
            loop: loop,
          ),
          hitBox: hitBox,
          playing: playing,
          position: position,
        ) {
    anchor = Anchor.center;
    log('tuhit ?!');
    hitBox = [
      Vector2(-1, -1),
      Vector2(-1, 1),
      Vector2(1, 1),
      Vector2(1, -1),
    ];
  }

  @override
  Future<void> onLoad() async {
    log('tuhit onload!');
    super.onLoad();
    setSpeed(50);
    _targeting = false;
  }

  late bool _targeting;
  @override
  void update(double dt) {
    super.update(dt);
    approachToUser(dt, getSpeed());
    attackNearestTarget();
  }

  void attackNearestTarget() async {
    if (_targeting) return null;
    _targeting = true;
    await Future.delayed(Duration(seconds: 1, milliseconds: 800));
    final enemy = await findTarget();
    if (enemy == null) {
      _targeting = false;
      return;
    }
    rotateToEnemy(enemy);
    await shootLaser(enemy);
    _targeting = false;
  }

  @override
  void render(ui.Canvas canvas) {
    super.render(canvas);
    //renderDebugMode(canvas);
  }
}
