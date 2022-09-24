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

class NemerteaShip extends Ship
    with CreatureObject, ExplodableObject
    implements GameObject {
  NemerteaShip({
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
    log('nemertea ?!');
    this.hitBox = [
      Vector2(-1, -1),
      Vector2(-1, 1),
      Vector2(1, 1),
      Vector2(1, -1),
    ];
  }

  @override
  Future<void> onLoad() async {
    log('nemertea onload!');
    super.onLoad();
    setArmor(50);
    setShield(50);
    attackNearestTargetRocket(duration: Duration(seconds: 3));
  }

  @override
  void update(double dt) {
    super.update(dt);
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
    giveCredit(5);
    log('Patladı!');
    super.onDie();
  }
}
