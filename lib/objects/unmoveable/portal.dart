import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:zspace/features/game/_services/igame_service.dart';
import 'package:zspace/injection_container.dart';
import 'package:zspace/objects/moveable/ships/user_ship.dart';
import '../../shared/app_images.dart';
import '../game_object.dart';

class Portal extends GameObject {
  List<Vector2>? hitBox;
  final Vector2 textureSize;
  final int spriteAmount;
  final double stepTime;
  final bool loop;
  final Function()? onJumped;
  Portal({
    ui.Image? image,
    SpriteAnimationData? animationData,
    Vector2? position,
    Vector2? size,
    double? angle,
    Anchor? anchor,
    int? priority,
    this.hitBox,
    required this.textureSize,
    this.spriteAmount: 1,
    this.stepTime: 0.1,
    this.loop: false,
    this.onJumped,
    bool playing: false,
  }) : super(
          image: image,
          animationData: SpriteAnimationData.sequenced(
            amount: spriteAmount,
            stepTime: stepTime,
            textureSize: textureSize,
            loop: loop,
          ),
          position: position,
          size: size,
          angle: angle,
          anchor: anchor,
          hitBox: hitBox,
          playing: playing,
        ) {
    anchor = Anchor.center;
    if (hitBox == null)
      this.hitBox = [
        Vector2(-1, -1),
        Vector2(-1, 1),
        Vector2(1, 1),
        Vector2(1, -1),
      ];
  }

  activate({required Function() onJumped}) async {
    var creatureImage =
        await this.gameRef.images.load(AppImages.portals.portalActive);

    final portalActive = Portal(
      image: creatureImage,
      size: Vector2(196.0, 196.0),
      textureSize: Vector2(340.0, 340.0),
      spriteAmount: 11,
      playing: true,
      position: this.position,
      loop: true,
      onJumped: onJumped,
      hitBox: [
        Vector2(-0.25, -0.25),
        Vector2(-0.25, 0.25),
        Vector2(0.25, 0.25),
        Vector2(0.25, -0.25),
      ],
    );
    portalActive.priority = this.priority - 1;
    this.gameRef.add(portalActive);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (playing) {
      if (other is UserShip) {
        playing = false;
        onJumped?.call();
      }
    }
  }
}
