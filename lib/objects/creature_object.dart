import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
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

    if (position != userShipPosition) {
      final diff = userShipPosition - position;
      final distance = diff.length;
      if (diff.length < speed) {
        //position.setFrom(userShipPosition);
      } else {
        diff.scaleTo(speed);
        position.setFrom(this.position + diff);
      }
    }

    rotateToObject(userShip);
  }
}
