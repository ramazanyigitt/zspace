import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'package:zspace/objects/unmoveable/explosions/normal_explosion.dart';
import 'game_object.dart';
import 'moveable/ships/user_ship.dart';
import 'unmoveable/game_map.dart';

mixin ExplodableObject on GameObject {
  void createSmallExplode(FlameGame game, Vector2 diff) async {
    final explosion =
        await GameObject.createExplosion<NormalExplosion>(game, this, diff);
    game.add(explosion);
    explosion.animation?.onComplete = () {
      explosion.gameRef.remove(explosion);
    };
  }
}
