import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/cupertino.dart' hide Image;
import '../game_object.dart';
import '../solid_object.dart';

class GameMap extends GameObject with SolidObject {
  Image image;
  GameMap(this.image, {required Vector2 size})
      : super(
          image: image,
          size: size,
        ) {
    if (hitBox == null)
      this.hitBox = [
        Vector2(-1, -1),
        Vector2(-1, 1),
        Vector2(1, 1),
        Vector2(1, -1),
      ];
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    //position = gameRef.camera.unprojectVector(_zeroVector);
  }

  Rect get bounds => Rect.fromLTWH(0, 0, size.x, size.y);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawImage(image, Offset.zero, Paint());
  }
}
