import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

class GameObject extends SpriteAnimationComponent
    with HasHitboxes, Collidable, HasGameRef {
  GameObject(
    ui.Image image, {
    SpriteAnimationData? animationData,
    bool? removeOnFinish,
    bool? playing,
    Paint? paint,
    Vector2? position,
    required Vector2 size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
    this.hitBox,
  }) : super.fromFrameData(
          image,
          animationData ??
              SpriteAnimationData.sequenced(
                  amount: 1, stepTime: 1, textureSize: size, loop: false),
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
  }
  List<Vector2>? hitBox;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    addHitbox(HitboxPolygon(hitBox!));
  }

  @override
  void update(double dt) {
    if (playing) {
      animation?.update(dt);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    animation?.getSprite().render(
          canvas,
          size: size,
          overridePaint: paint,
        );
    renderHitboxes(canvas);
  }
}
