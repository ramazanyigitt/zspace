import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zspace/data/models/episode_model.dart';
import 'package:zspace/features/_components/overlay/widgets/game_health_bar.dart';
import 'package:zspace/features/game/_services/igame_service.dart';
import 'package:zspace/injection_container.dart';
import 'package:zspace/objects/moveable/ships/user_ship.dart';
import 'package:zspace/objects/unmoveable/portal.dart';

import '../../../data/models/level_model.dart';
import '../../../objects/moveable/ships/ship.dart';
import '../../_components/overlay/lock_overlay.dart';
import '../../_components/overlay/widgets/game_credit_icon.dart';
import '../../_components/overlay/widgets/game_pause_button.dart';
import 'game_viewmodel.dart';

class GamePage extends FlameGame
    with
        HasDraggables,
        HasTappables,
        HasCollisionDetection,
        HasKeyboardHandlerComponents {
  late GameViewModel viewModel;
  LevelModel levelModel;
  EpisodeModel episodeModel;
  GamePage({required this.episodeModel, required this.levelModel}) {
    viewModel = GameViewModel(
      game: this,
      level: levelModel,
    );
  }

  @override
  @mustCallSuper
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    return super.onKeyEvent(event, keysPressed);
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

  late bool canGoNextLevel;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    canGoNextLevel = false;
    //LockOverlay().showClassicLoadingOverlay(buildAfterRebuild: true);
    await viewModel.prepareGame().whenComplete(() {
      //LockOverlay().closeOverlay();
    });
  }

  @override
  void update(double dt) {
    super.update(dt);
    //todo maybe move to this to ship ondied method can increase performance
    if (isLoaded && isMounted && viewModel.isStarted) {
      bool _isAllCreaturesDead = isAllCreaturesDead();
      if (_isAllCreaturesDead) {
        openPortal();
      }
    }
  }

  void openPortal() {
    if (canGoNextLevel) return;
    canGoNextLevel = true;
    log('is loaded and mounted ${children.length}');
    this.camera.shake(duration: 0.3, intensity: 10);
    final portal = children.whereType<Portal>().first;
    portal.activate(
      onJumped: goNextLevel,
    );
  }

  //locator<GameService>().goToNextLevel(episodeModel, levelModel);

  bool isAllCreaturesDead() {
    bool isAllDead = true;
    for (Component c in children) {
      if (c is Ship && !(c is UserShip)) {
        isAllDead = false;
      }
    }
    return isAllDead;
  }

  goNextLevel() {
    GamePauseButtonOverlay().closeCustomOverlay();
    GameCreditIconOverlay().closeCustomOverlay();
    GameHealthBarOverlay().closeCustomOverlay();
    locator<GameService>().goToNextLevel(episodeModel, levelModel);
  }

  @override
  void onRemove() {
    log('Removing game');
    super.onRemove();
    GamePauseButtonOverlay().closeCustomOverlay();
    GameCreditIconOverlay().closeCustomOverlay();
    GameHealthBarOverlay().closeCustomOverlay();
    pauseEngine();
    removeAll(children);
    detach();
    //detach();
  }
}
