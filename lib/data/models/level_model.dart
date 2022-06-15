import 'dart:convert';

import 'package:zspace/data/models/spawn_model.dart';

import '../enums/creature_types.dart';
import '../../domain/entities/level.dart';

class LevelModel extends Level {
  LevelModel({
    this.level,
    this.episodeId,
    this.spawnModels,
  }) : super(
          level: level,
          episodeId: episodeId,
          spawnModels: spawnModels,
        );

  final int? level;
  final int? episodeId;
  final List<SpawnModel>? spawnModels;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => LevelModel(
        level: json["level"] == null ? null : json["level"],
        episodeId: json["episodeId"] == null ? null : json["episodeId"],
        spawnModels: json["spawnModel"] == null
            ? null
            : List<SpawnModel>.from(
                json["spawnModel"].map((x) => SpawnModel().fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "level": level == null ? null : level,
        "episodeId": episodeId == null ? null : episodeId,
        "spawnModel": spawnModels == null
            ? null
            : List<dynamic>.from(spawnModels?.map((x) => x.toJson()) ?? []),
      };
}
