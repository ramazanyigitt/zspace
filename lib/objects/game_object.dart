import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:zspace/data/enums/creature_types.dart';
import 'package:zspace/objects/moveable/lasers/red_laser.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'package:zspace/objects/moveable/ships/tuhit.dart';
import 'package:zspace/objects/unmoveable/explosions/explosion.dart';
import 'package:zspace/objects/unmoveable/explosions/normal_explosion.dart';
import 'package:zspace/shared/app_images.dart';

import 'moveable/lasers/laser.dart';

class GameObject extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  bool? keepAngle;
  List<Vector2> hitBox;
  GameObject({
    ui.Image? image,
    SpriteAnimationData? animationData,
    bool? removeOnFinish,
    bool? playing,
    Paint? paint,
    Vector2? position,
    Vector2? textureSize,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
    required this.hitBox,
  }) : super(
          animation: image == null
              ? null
              : SpriteAnimation.fromFrameData(
                  image,
                  animationData ??
                      SpriteAnimationData.sequenced(
                        amount: 1,
                        stepTime: 1,
                        textureSize: textureSize ?? Vector2.zero(),
                        loop: false,
                      ),
                ),
          removeOnFinish: removeOnFinish,
          playing: playing,
          paint: paint,
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          priority: priority,
        ) {
    if (paint != null) {
      this.paint = paint;
    }
    /*if (hitBox == null)
      hitBox = [
        Vector2(-1, -1),
        Vector2(-1, 1),
        Vector2(1, 1),
        Vector2(1, -1),
      ];*/
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final hitboxPaint = BasicPalette.white.paint()
      ..style = PaintingStyle.stroke;

    add(
      PolygonHitbox.relative(hitBox, parentSize: size)
        ..paint = hitboxPaint
        ..renderShape = true,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (playing) {
      animation?.update(dt);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  static Future<Ship> create(CreatureType creatureType, FlameGame game) async {
    if (creatureType == CreatureType.Tuhit) {
      var creatureImage = await game.images.load(AppImages.ships.tuhitShip);
      return TuhitShip(
        image: creatureImage,
        shipSize: Vector2(128.0, 128.0),
        textureSize: Vector2(280.0, 280.0),
        spriteAmount: 1,
        playing: false,
        position: Vector2(250, 250),
        hitBox: [
          Vector2(-0.25, -1),
          Vector2(-1, 1),
          Vector2(1, 1),
          Vector2(0.25, -1),
        ],
      );
    } else {
      log("Error in GameObject",
          error: '$creatureType is not defined in GameObject');
      throw Exception('Error $creatureType is not defined in GameObject');
    }
  }

  static Future<T> createLaser<T extends Laser>(
      FlameGame game, GameObject target, GameObject shooter) async {
    if (T == RedLaser) {
      var creatureImage = await game.images.load(AppImages.lasers.redLaser);
      final lastPosition = Vector2(target.position.x, target.position.y);
      return RedLaser(
        image: creatureImage,
        target: lastPosition,
        size: Vector2(64.0, 64.0),
        textureSize: Vector2(144.0, 251.0),
        position: shooter.center,
        shooter: shooter,
        angle: shooter.angle,
        hitBox: [
          Vector2(-1, -1),
          Vector2(-1, 1),
          Vector2(1, 1),
          Vector2(1, -1),
        ],
      ) as T;
    } else {
      log("Error in GameObject", error: '$T is not defined in GameObject');
      throw Exception('Error $T is not defined in GameObject');
    }
  }

  static Future<T> createExplosion<T extends Explosion>(
      FlameGame game, GameObject explosionObject, Vector2 diff) async {
    if (T == NormalExplosion) {
      var creatureImage =
          await game.images.load(AppImages.explosions.normalExplosion);
      return NormalExplosion(
        image: creatureImage,
        size: Vector2(64.0, 64.0),
        position: explosionObject.position + diff,
        explosionObject: explosionObject,
        angle: explosionObject.angle,
        hitBox: [
          Vector2(-1, -1),
          Vector2(-1, 1),
          Vector2(1, 1),
          Vector2(1, -1),
        ],
      ) as T;
    } else {
      log("Error in GameObject", error: '$T is not defined in GameObject');
      throw Exception('Error $T is not defined in GameObject');
    }
  }
}
