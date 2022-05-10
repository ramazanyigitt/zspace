import 'package:flame/components.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'dart:ui' as ui;

class UserShip extends Ship {
  /// Pixels/s
  double maxSpeed = 300.0;

  final JoystickComponent joystick;
  final ui.Image image;
  final Vector2 shipSize;
  final Vector2 textureSize;
  final int spriteAmount;
  final double stepTime;
  List<Vector2>? hitBox;
  final bool loop;

  UserShip({
    required this.image,
    required this.joystick,
    required this.shipSize,
    required this.textureSize,
    this.spriteAmount: 1,
    this.stepTime: 0.1,
    this.hitBox,
    this.loop: false,
    bool playing: false,
  }) : super(
          image,
          size: shipSize,
          animationData: SpriteAnimationData.sequenced(
            amount: spriteAmount,
            stepTime: stepTime,
            textureSize: textureSize,
            loop: loop,
          ),
          hitBox: hitBox,
          playing: playing,
        ) {
    anchor = Anchor.center;

    if (hitBox == null)
      hitBox = [
        Vector2(-1, -1),
        Vector2(-1, 1),
        Vector2(1, 1),
        Vector2(1, -1),
      ];
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * maxSpeed * dt);
      angle = joystick.delta.screenAngle();
    }
  }

  @override
  void render(ui.Canvas canvas) {
    super.render(canvas);
    //renderDebugMode(canvas);
  }
}
