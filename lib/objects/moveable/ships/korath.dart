import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:zspace/objects/creature_object.dart';
import 'package:zspace/objects/explodable_object.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/moveable/lasers/red_laser.dart';
import 'ship.dart';
import 'dart:ui' as ui;

class KorathShip extends Ship
    with CreatureObject, ExplodableObject
    implements GameObject {
  KorathShip({
    CreatureSizeInfo? creatureSizeInfo,
    int spriteAmount: 1,
    double stepTime: 0.1,
    List<Vector2>? hitBox,
    bool loop: false,
    bool playing: false,
    Vector2? position,
  }) : super(
          image: creatureSizeInfo?.image,
          size: creatureSizeInfo?.creatureSize,
          animationData: SpriteAnimationData.sequenced(
            amount: spriteAmount,
            stepTime: stepTime,
            textureSize: creatureSizeInfo?.textureSize ?? Vector2.zero(),
            loop: loop,
          ),
          hitBox: hitBox,
          playing: playing,
          position: position,
          anchor: Anchor.center,
        ) {
    log('korath ?!');
    this.hitBox = [
      Vector2(-0.25, -1),
      Vector2(-1, 1),
      Vector2(1, 1),
      Vector2(0.25, -1),
    ];
  }

  @override
  Future<void> onLoad() async {
    log('korath onload!');
    super.onLoad();
    setSpeed(50);
  }

  @override
  void update(double dt) {
    super.update(dt);
    approachToUser(dt, getSpeed());
    attackNearestTarget();
  }

  @override
  void render(ui.Canvas canvas) {
    super.render(canvas);
    //renderDebugMode(canvas);
  }

  @override
  void onDie() {
    final diff = this.position - position;
    createNormalExplode(this.gameRef, diff);
    log('Patladı!');
    giveCredit(15);
    super.onDie();
  }
}
