import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'package:zspace/objects/unmoveable/explosions/blue_explosion.dart';
import 'package:zspace/objects/unmoveable/explosions/extra_small_explosion.dart';
import 'package:zspace/objects/unmoveable/explosions/normal_explosion.dart';
import 'package:zspace/objects/unmoveable/explosions/small_explosion.dart';
import 'game_object.dart';
import 'moveable/ships/user_ship.dart';
import 'unmoveable/game_map.dart';

mixin ExplodableObject on GameObject {
  void createSmallExplode(FlameGame game, Vector2 diff) async {
    final explosion =
        await GameObject.createExplosion<SmallExplosion>(game, this, diff);
    game.add(explosion);
    explosion.animation?.onComplete = () {
      explosion.gameRef.remove(explosion);
    };
  }

  void createNormalExplode(FlameGame game, Vector2 diff,
      {double? damage}) async {
    final explosion = await GameObject.createExplosion<NormalExplosion>(
      game,
      this,
      diff,
      damage: damage,
    );
    game.add(explosion);
    explosion.animation?.onComplete = () {
      explosion.gameRef.remove(explosion);
    };
  }

  void createShipExplode(FlameGame game, Vector2 diff) async {
    final explosion =
        await GameObject.createExplosion<BlueExplosion>(game, this, diff);
    game.add(explosion);
    explosion.animation?.onComplete = () {
      explosion.gameRef.remove(explosion);
    };
  }

  void createExtraSmallExplode(FlameGame game, Vector2 diff) async {
    final explosion =
        await GameObject.createExplosion<ExtraSmallExplosion>(game, this, diff);
    game.add(explosion);
    explosion.animation?.onComplete = () {
      explosion.gameRef.remove(explosion);
    };
  }
}
