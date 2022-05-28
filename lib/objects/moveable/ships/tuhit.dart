import 'dart:developer';

import 'package:flame/components.dart';
import 'package:zspace/objects/creature_object.dart';
import 'package:zspace/objects/game_object.dart';
import 'ship.dart';
import 'dart:ui' as ui;

class TuhitShip extends Ship with CreatureObject implements GameObject {
  TuhitShip({
    ui.Image? image,
    Vector2? shipSize,
    Vector2? textureSize,
    int spriteAmount: 1,
    double stepTime: 0.1,
    List<Vector2>? hitBox,
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
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    setSpeed(50);
  }

  @override
  void update(double dt) {
    super.update(dt);
    approachToUser(dt, getSpeed());
    /*if (!joystick.delta.isZero()) {
      //log('Moving as ${joystick.relativeDelta * maxSpeed * dt}');
      position.add(joystick.relativeDelta * maxSpeed * dt);
      if (!isColliding) {
        //angle = joystick.delta.screenAngle();
      }
    }*/
  }

  @override
  void render(ui.Canvas canvas) {
    super.render(canvas);
    renderDebugMode(canvas);
  }
}
