import 'dart:developer';

import 'package:flame/components.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/moveable/lasers/laser.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'package:zspace/objects/unmoveable/explosions/explosion.dart';
import 'dart:ui' as ui;

import '../../explodable_object.dart';

class BlueExplosion extends Explosion
    with ExplodableObject
    implements GameObject {
  List<Vector2>? hitBox;
  GameObject explosionObject;
  BlueExplosion({
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
            amount: 9,
            stepTime: 0.1,
            textureSize: Vector2(340, 340),
            loop: false,
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

  @override
  Future<void> onLoad() async {
    super.onLoad();
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
