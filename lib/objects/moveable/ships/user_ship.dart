import 'dart:ui' as ui;

import 'package:flame/components.dart';
import '../moveable_object.dart';

class UserShip extends MoveableObject {
  UserShip(
    ui.Image image, {
    SpriteAnimationData? animationData,
    Vector2? position,
    required Vector2 size,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super(
          image,
          animationData: animationData,
          position: position,
          size: size,
          angle: angle,
          anchor: anchor,
        ) {
    hitBox = [
      Vector2(0.2, -1.0),
      Vector2(-0.65, -0.1),
      Vector2(-0.6, 0.8),
      Vector2(0.6, 0.8),
      Vector2(0.8, -0.1),
    ];
  }
}
