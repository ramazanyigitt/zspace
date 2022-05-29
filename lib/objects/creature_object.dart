import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:zspace/objects/moveable/lasers/red_laser.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'game_object.dart';
import 'moveable/ships/user_ship.dart';
import 'unmoveable/game_map.dart';

mixin CreatureObject on GameObject {
  rotateToUser() {
    var userShip = gameRef.children.whereType<UserShip>().first;

    final enemyPosition = userShip.position;
    final myPosition = position;
    final angle = (enemyPosition - myPosition).screenAngle();
    this.angle = angle;
  }

  rotateToObject(GameObject object) {
    final enemyPosition = object.position;
    final myPosition = position;
    final angle = (enemyPosition - myPosition).screenAngle();
    this.angle = angle;
  }

  approachToUser(double dt, double maxSpeed) {
    var userShip = gameRef.children.whereType<UserShip>().first;

    var userShipPosition = userShip.position;

    var speed = maxSpeed * dt;

    final diff = userShipPosition - position;
    if (position != userShipPosition &&
        ((diff.x.abs()) > userShip.size.x * 2 ||
            (diff.y.abs() > userShip.size.y * 2))) {
      if (diff.length < speed) {
        position.setFrom(userShipPosition);
      } else {
        diff.scaleTo(speed);
        position.setFrom(this.position + diff);
      }
    }

    rotateToObject(userShip);
  }

  void rotateToEnemy(GameObject enemy) {
    final enemyPosition = enemy.position;
    final myPosition = position;
    final angle = (enemyPosition - myPosition).screenAngle();
    this.angle = angle;
  }

  Future<void> shootLaser(GameObject enemy) async {
    log('Enemy: $enemy this: $this');
    final laser =
        await GameObject.createLaser<RedLaser>(this.gameRef, enemy, this);
    this.gameRef.add(laser);
  }

  Future<GameObject?> findTarget() async {
    final component = gameRef.children.firstWhere((value) => value is UserShip);

    final enemy = component as Ship;
    return enemy;
  }
}
