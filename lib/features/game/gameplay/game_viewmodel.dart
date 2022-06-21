import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/data/enums/win_point_category.dart';
import 'package:zspace/data/models/market_item_model.dart';
import 'package:zspace/domain/repositories/data_repository.dart';
import 'package:zspace/features/_components/overlay/lock_overlay.dart';
import 'package:zspace/features/_components/overlay/widgets/game_pause_button.dart';
import 'package:zspace/features/game/_services/ispawn_service.dart';
import 'package:zspace/injection_container.dart';

import '../../../data/models/level_model.dart';
import '../../../domain/entities/inventory_item.dart';
import '../../../objects/moveable/ships/user_ship.dart';
import '../../../objects/unmoveable/game_map.dart';
import '../../../shared/app_images.dart';
import '../../_components/overlay/lock_overlay_dialog.dart';
import '../../_components/overlay/widgets/custom_dialog.dart';
import '../_services/igame_service.dart';
import 'game_page.dart';

class GameViewModel extends BaseViewModel {
  GamePage game;
  LevelModel level;
  GameViewModel({
    required this.game,
    required this.level,
  });

  late bool isStarted;

  late final JoystickComponent joystick;
  final knobPaint = BasicPalette.blue.withAlpha(200).paint();
  final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();

  Future<void> prepareGame() async {
    isStarted = false;
    //Camera
    game.camera.viewport = FixedResolutionViewport(Vector2(1.sw, 1.sh));

    //Map

    var mapImage = await game.images.load(AppImages.mapEpisode1Level1.gameMap);
    var map = GameMap(
      mapImage,
      size: Vector2(738, 1312),
    );
    map.priority = -2;
    game.add(map);

    //User
    joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 15,
        paint: knobPaint,
      ),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      anchor: Anchor.center,
      position: Vector2(-5000, -5000),
      size: 15,
    );

    final player = await getUserWithEquippedItems();

    //Camera set up
    game.camera.speed = 1;
    game.camera.followComponent(player,
        worldBounds: map.bounds, relativeOffset: Anchor.center);

    game.add(player);
    game.add(joystick);

    await locator<GameService>().spawnService.spawnCreatures(
          game,
          locator<GameService>().getSpawnModels(level),
        );
    isStarted = true;
    GamePauseButtonOverlay().show(
      forceOverlay: true,
      text: 'text',
      buttonText: '',
      onTap: () {
        game.pauseEngine();
      },
      onClickResume: () {
        game.resumeEngine();
      },
      onClickMainMenu: () {
        GamePauseButtonOverlay().closeCustomOverlay();
        game.removeAll(game.children);
        Get.back();
      },
    );
  }

  Future<UserShip> getUserWithEquippedItems() async {
    final equippedItemsResponse =
        await locator<DataRepository>().getEquippedInventory();
    double speed = 0, shield = 0, armor = 0, damage = 0;
    late String shipPath;
    log('Equipped items response ${equippedItemsResponse}');
    if (equippedItemsResponse is Right) {
      final equippedItems =
          ((equippedItemsResponse as Right).value as List<InventoryItem>);
      for (InventoryItem inventoryItem in equippedItems) {
        if (inventoryItem.item!.isShip) {
          armor += inventoryItem.item!.ship!.armor!;
          shield += inventoryItem.item!.ship!.shield!;
          speed += inventoryItem.item!.ship!.speed!;
          shipPath = inventoryItem.item!.getShipPath;
        } else if (inventoryItem.item!.isWeapon) {
          damage += inventoryItem.item!.weapon!.damage!;
        } else if (inventoryItem.item!.isEnergyGenerator) {
          speed += inventoryItem.item!.energyGenerator!.shipSpeed!;
        } else if (inventoryItem.item!.isShieldGenerator) {
          shield += inventoryItem.item!.shieldGenerator!.shieldAmount!;
        }
      }
    }

    var userShipImage = await game.images.load(shipPath);
    final player = UserShip(
      image: userShipImage,
      joystick: joystick,
      shipSize: Vector2(128.0, 128.0),
      textureSize: Vector2(550.0, 648.0),
      spriteAmount: 1,
      playing: true,
      hitBox: [
        Vector2(-1, -1),
        Vector2(-1, 1),
        Vector2(1, 1),
        Vector2(1, -1),
      ],
      speed: speed,
      armor: armor,
      shield: shield,
      damage: damage,
      //loop: true,
    );
    return player;
  }

  gameOver() async {
    game.pauseEngine();
    game.removeAll(game.children);
    //LockOverlay().showClassicLoadingOverlay(buildAfterRebuild: true);
    LockOverlayDialog().showCustomOverlay(
      child: CustomDialog(
        titleText: 'Game over',
        descriptionText: 'You fought but you lost, next time soldier!',
        button1Text: 'Done',
        disableCancelButton: true,
        image: 'dead-emoji.gif',
        onButton1Tap: () {
          Get.back();
          LockOverlayDialog().closeOverlay();
        },
        onClickOutside: () {
          Get.back();
          LockOverlayDialog().closeOverlay();
        },
      ),
    );
    //await Future.delayed(Duration(seconds: 2));
    //LockOverlay().closeOverlay();
    //Get.back();
  }
}
