import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:zspace/domain/repositories/data_repository.dart';
import 'package:zspace/features/_components/overlay/game_snackbar_overlay.dart';
import 'package:zspace/features/game/gameplay/game_page.dart';
import 'package:zspace/injection_container.dart';
import 'package:zspace/objects/moveable/lasers/red_laser.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'package:zspace/objects/unmoveable/health_bar.dart';
import 'game_object.dart';
import 'moveable/rockets/short_rocket.dart';
import 'moveable/ships/user_ship.dart';
import 'unmoveable/game_map.dart';

mixin CreatureObject on Ship {
  @mustCallSuper
  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  rotateToUser() {
    var userShip = gameRef.children.whereType<UserShip>().first;

    rotateToObject(userShip);
  }

  rotateToObject(GameObject object) {
    final enemyPosition = object.position;
    final myPosition = position;
    final angle = (enemyPosition - myPosition).screenAngle();
    this.angle = angle;
  }

  approachToUser(
    double dt,
    double maxSpeed, {
    double? maxDistance,
    double maxDistanceUserShip = 2,
    Function(Vector2)? onReach,
  }) {
    var userShip = gameRef.children.whereType<UserShip>().first;

    var userShipPosition = userShip.position;

    var speed = maxSpeed * dt;

    final diff = userShipPosition - position;
    final diffX = diff.x.abs();
    final diffY = diff.y.abs();
    final maxDiffX = maxDistance ?? userShip.size.x * maxDistanceUserShip;
    final maxDiffY = maxDistance ?? userShip.size.y * maxDistanceUserShip;

    if ((diffX > maxDiffX || (diffY > maxDiffY))) {
      if (diff.length < speed) {
        position.setFrom(userShipPosition);
      } else {
        diff.scaleTo(speed);
        position.setFrom(this.position + diff);
      }
    } else {
      if (onReach != null) {
        final latestPosition = Vector2(userShipPosition.x, userShipPosition.y);
        onReach(latestPosition);
      }
    }

    rotateToObject(userShip);
  }

  Future<void> randomTeleport() async {
    final int randomSecond = new math.Random().nextInt(10);
    await Future.delayed(Duration(seconds: randomSecond));
    if (gameRef.paused) {
      randomTeleport();
      return;
    }
    final maxSize = (this.gameRef as GamePage).size;
    final double randomX =
        new math.Random().nextInt(maxSize.x.toInt()).toDouble();
    final double randomY =
        new math.Random().nextInt(maxSize.y.toInt()).toDouble();
    if (maxSize.x > randomX && maxSize.y > randomY) {
      log('Inside world can teleport');
      this.position = Vector2(randomX, randomY);
      var userShip = gameRef.children.whereType<UserShip>().first;
      for (int i = 0; i < 3; i++) {
        await Future.delayed(Duration(milliseconds: 200));
        shootLaser(
          userShip,
        );
      }
    } else {
      log('Outside world can teleport x: $randomX y: $randomY maxSize: $maxSize');
    }
    final int randomWaitSecond = new math.Random().nextInt(5);
    await Future.delayed(Duration(seconds: randomWaitSecond));
    randomTeleport();
  }

  void attackNearestTarget({
    String? lastKey,
    double? damage,
  }) async {
    if (lastKey != lastMoveKey) return;
    if (targeting == true) return null;
    targeting = true;
    await Future.delayed(Duration(milliseconds: 500));
    if (lastKey != lastMoveKey) {
      targeting = false;
      return;
    }
    final enemy = await findTarget();
    if (enemy == null || moving == true) {
      targeting = false;
      return;
    }
    if (lastKey != lastMoveKey) {
      targeting = false;
      return;
    }
    rotateToObject(enemy);
    await shootLaser(enemy, damage: damage);
    await Future.delayed(Duration(milliseconds: 800));
    targeting = false;
  }

  Future<void> shootLaser(GameObject enemy, {double? damage}) async {
    final laser = await GameObject.createLaser<RedLaser>(
        this.gameRef, enemy, this,
        damage: damage);
    this.gameRef.add(laser);
  }

  Future<void> shootRocket(GameObject enemy) async {
    final laser =
        await GameObject.createRocket<ShortRocket>(this.gameRef, enemy, this);
    this.gameRef.add(laser);
  }

  void attackNearestTargetRocket({required Duration duration}) async {
    await Future.delayed(duration);
    if (!this.isMounted) return;
    final enemy = await findTarget();
    if (enemy == null) {
      return;
    }
    if (!gameRef.isAttached || gameRef.paused) return;
    await shootRocket(enemy);
    attackNearestTargetRocket(duration: duration);
  }

  Future<GameObject?> findTarget() async {
    final component = gameRef.children.firstWhere((value) => value is UserShip);
    //TODO fix here it is casuing to stucking when click pause repeatadly

    final enemy = component as Ship;
    return enemy;
  }

  giveCredit(int amount) {
    locator<DataRepository>().addCredit(amount);
    GameSnackbarOverlay().show(
      text: 'You gain $amount Credit',
      buttonText: '',
      forceOverlay: true,
      fullTap: true,
      onTap: () {
        GameSnackbarOverlay().closeCustomOverlay();
      },
      removeDuration: Duration(seconds: 2),
    );
  }
}
