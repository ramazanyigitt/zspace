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

class TuhitShip extends Ship
    with CreatureObject, ExplodableObject
    implements GameObject {
  TuhitShip({
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
    log('tuhit ?!');
    this.hitBox = [
      Vector2(-0.85, -0.75),
      Vector2(-0.5, 0.25),
      Vector2(-0.30, 1),
      Vector2(0.1, 1),
      Vector2(0.40, 0.25),
      Vector2(0.85, 0),
      Vector2(0.95, -0.5),
    ];
  }

  late bool _isAttacking;
  @override
  Future<void> onLoad() async {
    log('tuhit onload!');
    super.onLoad();
    setArmor(50);
    setShield(100);
    setSpeed(50);
    _isAttacking = false;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isAttacking) return;
    approachToUser(dt, getSpeed(), maxDistanceUserShip: 1,
        onReach: (Vector2 location) {
      _isAttacking = true;
      attack(location);
    });
  }

  attack(Vector2 location) async {
    log('ATTACKING!!!');
    rotateForAttack();
    await Future.delayed(Duration(seconds: 1));
    this.position = location;
    await Future.delayed(Duration(milliseconds: 50));
    final diff = this.position - position;
    if (!this.isMounted) return;
    createNormalExplode(this.gameRef, diff, damage: 50);
    _isAttacking = false;
    onDie(isKilled: false);
  }

  rotateForAttack() async {
    if (_isAttacking) {
      this.angle += 2;
      await Future.delayed(Duration(milliseconds: 8));
      rotateForAttack();
    }
  }

  @override
  void render(ui.Canvas canvas) {
    super.render(canvas);
    //renderDebugMode(canvas);
  }

  @override
  void onDie({bool isKilled: true}) {
    final diff = this.position - position;
    createNormalExplode(this.gameRef, diff);
    log('Patladı!');
    if (isKilled) giveCredit(10);
    super.onDie();
  }
}
