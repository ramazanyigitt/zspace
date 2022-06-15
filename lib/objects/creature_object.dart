import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:zspace/objects/moveable/lasers/red_laser.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'game_object.dart';
import 'moveable/rockets/short_rocket.dart';
import 'moveable/ships/user_ship.dart';
import 'unmoveable/game_map.dart';

mixin CreatureObject on Ship {
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

  void attackNearestTarget({
    String? lastKey,
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
    await shootLaser(enemy);
    await Future.delayed(Duration(milliseconds: 800));
    targeting = false;
  }

  Future<void> shootLaser(GameObject enemy) async {
    final laser =
        await GameObject.createLaser<RedLaser>(this.gameRef, enemy, this);
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
    if (!gameRef.isAttached) return;
    await shootRocket(enemy);
    attackNearestTargetRocket(duration: duration);
  }

  Future<GameObject?> findTarget() async {
    final component = gameRef.children.firstWhere((value) => value is UserShip);

    final enemy = component as Ship;
    return enemy;
  }
}
