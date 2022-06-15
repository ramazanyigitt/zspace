import 'dart:developer';

import 'package:flame/components.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/moveable/lasers/laser.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'package:zspace/objects/unmoveable/explosions/explosion.dart';
import 'dart:ui' as ui;

import '../../explodable_object.dart';

class NormalExplosion extends Explosion
    with ExplodableObject
    implements GameObject {
  List<Vector2>? hitBox;
  GameObject explosionObject;
  NormalExplosion({
    required this.explosionObject,
    ui.Image? image,
    Vector2? position,
    Vector2? size,
    double? angle,
    Anchor? anchor,
    int? priority,
    required this.hitBox,
    double? damage,
  }) : super(
          image: image,
          animationData: SpriteAnimationData.sequenced(
            amount: 25,
            stepTime: 0.05,
            textureSize: (size! / 2),
            loop: false,
            amountPerRow: 5,
          ),
          position: position,
          size: size,
          angle: angle,
          anchor: anchor,
          hitBox: hitBox,
          damage: damage,
        ) {
    anchor = Anchor.center;
  }

  late List<PositionComponent> damaged;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    damaged = [];
    setDamage(damage ?? 0);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Ship) {
      if (other != explosionObject && !damaged.contains(other)) {
        damaged.add(other);
        other.getDamageNormal(getDamage());
        log('Armor: ${other.getArmor()} shield ${other.getShield()}');
      }
      /*if (other != shooter) {
        other.getArmor();
        this.gameRef.remove(this);
        this.removeFromParent();
      }*/
    }
  }

  @override
  void render(ui.Canvas canvas) {
    super.render(canvas);
    //renderDebugMode(canvas);
  }
}
