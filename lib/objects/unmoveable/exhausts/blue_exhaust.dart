import 'dart:developer';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'package:zspace/objects/unmoveable/exhausts/exhaust.dart';
import 'dart:ui' as ui;

import '../../explodable_object.dart';

class BlueExhaust extends Exhaust {
  List<Vector2>? hitBox;
  Ship shipObject;
  ui.Image image;
  BlueExhaust({
    required this.shipObject,
    required this.image,
    required int frameAmount,
    Vector2? position,
    Vector2? size,
    double? angle,
    Anchor? anchor,
    int? priority,
    double? damage,
    this.hitBox,
  }) : super(
          image: image,
          animationData: SpriteAnimationData.sequenced(
            amount: frameAmount,
            stepTime: 0.1,
            textureSize: size ?? Vector2(0, 0),
            loop: true,
          ),
          position: position,
          size: size,
          angle: angle,
          anchor: anchor,
          hitBox: hitBox,
        ) {
    if (this.hitBox == null)
      this.hitBox = [
        Vector2(-1, -1),
        Vector2(-1, 1),
        Vector2(1, 1),
        Vector2(1, -1),
      ];
    anchor = Anchor.center;
  }

  bool isVisible = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    /*animation!.onFrame = (frame) {
      if (lastSpeedFrameIndex == null) return;
      /*if (frame == lastSpeedFrameIndex) {
        setToIndex(lastSpeedFrameIndex + 1);
      } else if (frame - 1 == lastSpeedFrameIndex) {
        setToIndex(lastSpeedFrameIndex);
      }*/
    };*/
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (shipObject.moving) {
      if (!playing) {
        isVisible = true;
        playing = true;
      }
      changeExhaustWithSpeed(dt);
    } else {
      if (playing) {
        setToIndex(0);
        isVisible = false;
        playing = false;
      }
    }
  }

  void changeExhaustWithSpeed(double dt) {
    this.priority = -1;
    final maxSpeed = shipObject.getSpeed();
    final currentSpeed = shipObject.currentSpeedVelocity != null
        ? ((shipObject.currentSpeedVelocity!.normalize() / dt) + 0.5)
        : shipObject.getSpeed();

    final frameLength = 10;
    final speedPercentagePerFrame = maxSpeed / frameLength;
    final opacityPercentagePerFrame = 0.5 / frameLength;

    for (int i = 0; i < frameLength; i++) {
      var speedFrameIndex = currentSpeed ~/ speedPercentagePerFrame;

      if (speedFrameIndex < 1) {
        speedFrameIndex = 1;
      }

      if (speedFrameIndex > frameLength) {
        speedFrameIndex = frameLength;
      }

      position = shipObject.positionOf(
          Vector2((shipObject.size.x - size.x) / 2, size.y - size.y / 10));
      angle = shipObject.angle;
      //this.setOpacity(opacityPercentagePerFrame * speedFrameIndex + 0.5);
      /*position = Vector2(
          (shipObject.size.x - size.x) / 2,
          shipObject.size.y -
              (size.y * ((frameLength - speedFrameIndex) / frameLength)));*/

      //setToIndex(speedFrameIndex - 1);
    }
    /*if (currentSpeed >= maxSpeed) {
      setToIndex(frameLength - 1);
      position = Vector2(
          (shipObject.size.x - size.x) / 2, shipObject.size.y - (size.y / 4));
    } else if (currentSpeed >= maxSpeed) {
      setToIndex(0);
    } else {
      setToIndex(0);
    }*/
  }

  void setToIndex(int index) {
    animation!.currentIndex = index;
    animation!.clock = animation!.frames[animation!.currentIndex].stepTime;
    animation!.elapsed = animation!.totalDuration();
    animation!.update(0);
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
    if (isVisible) {
      super.render(canvas);
    }
  }
}
