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

  void onDie() {
    final diff = this.position - position;
    createNormalExplode(this.gameRef, diff);
    log('Patladı!');
    this.gameRef.remove(this);
    this.removeFromParent();
  }
}
