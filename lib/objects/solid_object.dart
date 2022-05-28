import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'game_object.dart';
import 'moveable/ships/user_ship.dart';
import 'unmoveable/game_map.dart';

enum CollisionDirection {
  TOP,
  LEFT,
  RIGHT,
  BOTTOM,
  NONE,
}

mixin SolidObject on GameObject {
  @override
  @mustCallSuper
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    List<CollisionDirection> direction = [];
    for (var point in intersectionPoints) {
      direction.addAll(_getCollisionDirection(point));
    }

    if (other is UserShip) {
      other.keepAngle = true;
      if (other.joystick.delta != Vector2.zero()) {
        other.angle = other.joystick.delta.screenAngle();
      }
      final delta = other.joystick.delta;
      if (direction.contains(CollisionDirection.TOP)) {
        if (other.joystick.delta.y > 0) {
          delta.multiply(Vector2(1, 1));
        } else if (delta.y < 0) {
          delta.multiply(Vector2(1, 0));
        }
      }
      if (direction.contains(CollisionDirection.BOTTOM)) {
        if (delta.y > 0) {
          delta.multiply(Vector2(1, 0));
        } else if (delta.y < 0) {
          delta.multiply(Vector2(1, 1));
        }
      }
      if (direction.contains(CollisionDirection.LEFT)) {
        if (delta.x > 0) {
          delta.multiply(Vector2(1, 1));
        } else if (delta.x < 0) {
          delta.multiply(Vector2(0, 1));
        }
      }
      if (direction.contains(CollisionDirection.RIGHT)) {
        if (delta.x > 0) {
          delta.multiply(Vector2(0, 1));
        } else if (delta.x < 0) {
          delta.multiply(Vector2(1, 1));
        }
      }
    }
  }

  List<CollisionDirection> _getCollisionDirection(Vector2 intersection) {
    List<CollisionDirection> direction = [];
    final x = intersection.x.roundToDouble();
    final y = intersection.y.roundToDouble();
    if (x <= 0) {
      direction.add(CollisionDirection.LEFT);
    }
    if (x >= size.x) {
      direction.add(CollisionDirection.RIGHT);
    }
    if (y <= 0) {
      direction.add(CollisionDirection.TOP);
    }
    if (y >= size.y) {
      direction.add(CollisionDirection.BOTTOM);
    }
    return direction;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is GameObject) {
      other.keepAngle = false;
    }
  }
}
