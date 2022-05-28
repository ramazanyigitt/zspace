import 'dart:developer';

import 'package:flame/game.dart';
import 'package:flame/input.dart';

import '../../../data/models/level_model.dart';
import '../../_components/overlay/lock_overlay.dart';
import 'game_viewmodel.dart';

class GamePage extends FlameGame
    with HasDraggables, HasTappables, HasCollisionDetection {
  late GameViewModel viewModel;
  LevelModel levelModel;
  GamePage(this.levelModel) {
    viewModel = GameViewModel(
      game: this,
      level: levelModel,
    );
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    viewModel.joystick.position =
        Vector2(info.eventPosition.global.x, info.eventPosition.global.y);
    log('Tap down added to joystick');
    super.onTapDown(pointerId, info);
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    log('Tap up stops');
    stopJoystick();
    super.onTapUp(pointerId, info);
  }

  /*@override
  void onDragStart(int pointerId, DragStartInfo details) {
    viewModel.joystick.position =
        Vector2(details.eventPosition.global.x, details.eventPosition.global.y);
    super.onDragStart(pointerId, details);
  }*/

  @override
  void onDragEnd(int pointerId, DragEndInfo details) {
    log('Drag end stops');
    stopJoystick();
    super.onDragEnd(pointerId, details);
  }

  @override
  void onDragCancel(int pointerId) {
    log('Drag cancel stops');
    stopJoystick();
    super.onDragCancel(pointerId);
  }

  stopJoystick() {
    viewModel.joystick.delta.setZero();
    viewModel.joystick.position = Vector2(5000, 5000);
    //viewModel.joystick.removeFromParent();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    LockOverlay().showClassicLoadingOverlay(buildAfterRebuild: true);
    await viewModel.prepareGame().whenComplete(() {
      //LockOverlay().closeOverlay();
    });
    /*joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 30,
        paint: knobPaint,
      ),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      position: Vector2(100, 100),
      size: 15,
    );

    var spriteSheet = await images.load('ninja_boy_glide_ss.png');
    var player = UserShip(
      image: spriteSheet,
      joystick: joystick,
      textureSize: Vector2(150.0, 150.0),
      spriteAmount: 10,
    );

    add(player);*/
  }
}
