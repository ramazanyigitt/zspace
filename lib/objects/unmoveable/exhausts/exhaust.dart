import 'dart:ui' as ui;

import 'package:flame/components.dart';
import '../../game_object.dart';

abstract class Exhaust extends GameObject {
  Exhaust({
    ui.Image? image,
    SpriteAnimationData? animationData,
    Vector2? position,
    Vector2? size,
    double? angle,
    Anchor? anchor,
    int? priority,
    List<Vector2>? hitBox,
  }) : super(
          image: image,
          animationData: animationData,
          position: position,
          size: size,
          angle: angle,
          anchor: anchor,
          hitBox: hitBox,
        );
}
