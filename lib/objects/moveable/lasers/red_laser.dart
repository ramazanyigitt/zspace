import 'dart:developer';

import 'package:flame/components.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/moveable/lasers/laser.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'package:zspace/objects/unmoveable/game_map.dart';
import 'dart:ui' as ui;

import '../../explodable_object.dart';

class RedLaser extends Laser with ExplodableObject implements GameObject {
  List<Vector2>? hitBox;
  final double? damage;
  RedLaser({
    required GameObject shooter,
    required Vector2 target,
    required Vector2 textureSize,
    ui.Image? image,
    Vector2? position,
    Vector2? size,
    double? angle,
    Anchor? anchor,
    int? priority,
    required this.hitBox,
    this.damage,
  }) : super(
          shooter: shooter,
          image: image,
          animationData: SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: textureSize,
            loop: false,
          ),
          position: position,
          size: size,
          angle: angle,
          anchor: anchor,
          hitBox: hitBox,
          target: target,
        ) {
    anchor = Anchor.center;
    hitBox = [
      Vector2(-0.5, -0.75),
      Vector2(-0.5, 0.75),
      Vector2(0.5, 0.75),
      Vector2(0.5, -0.75),
    ];
  }

  Vector2? speed;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    setSpeed(750);
    setDamage(this.damage ?? 15);
    //rotateToEnemy();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (speed == null) {
      final ds = getSpeed() * dt;
      speed = target - position;
      speed!.scaleTo(ds);
    }

    position.setFrom(position + speed!);
  }

  void rotateToEnemy() {
    final myPosition = position;
    final angle = (target - myPosition).screenAngle();
    this.angle = angle;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Ship) {
      if (other != shooter) {
        other.getDamageNormal(getDamage());
        log('Armor: ${other.getArmor()} shield ${other.getShield()}');
        final diff = other.position - position;
        createExtraSmallExplode(this.gameRef, diff);
        this.gameRef.remove(this);
        this.removeFromParent();
      }
    } else if (other is GameMap) {
      this.gameRef.remove(this);
      this.removeFromParent();
    }
  }

  @override
  void render(ui.Canvas canvas) {
    super.render(canvas);
    //renderDebugMode(canvas);
  }
}
