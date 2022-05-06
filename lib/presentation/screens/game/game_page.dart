import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:zspace/presentation/screens/game/game_viewmodel.dart';
import 'package:zspace/presentation/widgets/overlay/lock_overlay.dart';

class GamePage extends FlameGame
    with HasDraggables, HasTappables, HasCollidables {
  late GameViewModel viewModel;
  GamePage() {
    viewModel = GameViewModel(game: this);
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    viewModel.joystick.position =
        Vector2(info.eventPosition.global.x, info.eventPosition.global.y);
    add(viewModel.joystick);
    super.onTapDown(pointerId, info);
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    stopJoystick();
    super.onTapUp(pointerId, info);
  }

  @override
  void onDragStart(int pointerId, DragStartInfo details) {
    viewModel.joystick.position =
        Vector2(details.eventPosition.global.x, details.eventPosition.global.y);
    super.onDragStart(pointerId, details);
  }

  @override
  void onDragEnd(int pointerId, DragEndInfo details) {
    stopJoystick();
    super.onDragEnd(pointerId, details);
  }

  @override
  void onDragCancel(int pointerId) {
    stopJoystick();
    super.onDragCancel(pointerId);
  }

  stopJoystick() {
    viewModel.joystick.delta.setZero();
    remove(viewModel.joystick);
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
