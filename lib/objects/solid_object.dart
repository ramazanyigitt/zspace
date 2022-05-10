import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/unmoveable/game_map.dart';

mixin SolidObject on GameObject {
  @override
  @mustCallSuper
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    log('$runtimeType collided with $other');
    if (runtimeType == GameMap) {
      other.flipVertically();
      return;
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(Collidable __) {
    super.onCollisionEnd(__);
  }
}
