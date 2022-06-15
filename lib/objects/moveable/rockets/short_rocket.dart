import 'dart:developer';

import 'package:flame/components.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/moveable/rockets/rocket.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'package:zspace/objects/moveable/ships/user_ship.dart';
import 'package:zspace/objects/unmoveable/game_map.dart';
import 'dart:ui' as ui;

import '../../explodable_object.dart';

class ShortRocket extends Rocket with ExplodableObject implements GameObject {
  ShortRocket({
    required GameObject shooter,
    required GameObject target,
    required Vector2 textureSize,
    ui.Image? image,
    Vector2? position,
    Vector2? size,
    double? angle,
    Anchor? anchor,
    int? priority,
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
          target: target,
        ) {
    anchor = Anchor.center;
    hitBox = [
      Vector2(-1, -1),
      Vector2(-1, 1),
      Vector2(1, 1),
      Vector2(1, -1),
    ];
  }

  Vector2? lastTargetPosition;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    setSpeed(500);
    setDamage(15);
    //rotateToEnemy();
  }

  @override
  void update(double dt) {
    super.update(dt);

    final ds = getSpeed() * dt;
    if (lastTargetPosition != null) {
      rotateToPosition(lastTargetPosition!);
      position.moveToTarget(lastTargetPosition!, ds);
      if (this.position == lastTargetPosition) {
        createSmallExplode(this.gameRef, Vector2.zero());
        this.gameRef.remove(this);
        this.removeFromParent();
      }
    } else if (this.position != target.position) {
      rotateToPosition(target.position);
      final diff = target.position - position;
      if (diff.x.abs() < (target.size.x * 1.5) &&
          diff.y.abs() < (target.size.y * 1.5)) {
        if (diff.length < ds) {
          position.setFrom(target.position);
          createSmallExplode(this.gameRef, Vector2.zero());
          this.gameRef.remove(this);
          this.removeFromParent();
        } else {
          if (target is UserShip)
            log('lAST TARGET ENABLED $lastTargetPosition and diff $diff');
          diff.scaleTo(ds);
          position.setFrom(position + diff);
          lastTargetPosition = Vector2(target.position.x, target.position.y);
        }
      } else {
        diff.scaleTo(ds);
        position.setFrom(position + diff);
      }
    }
  }

  void rotateToPosition(Vector2 targetPosition) {
    final myPosition = position;
    final angle = (targetPosition - myPosition).screenAngle();
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
        createSmallExplode(this.gameRef, diff);
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
