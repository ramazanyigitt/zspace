import 'dart:convert';

import '../enums/creature_types.dart';
import '../../domain/entities/level.dart';

class LevelModel extends Level {
  LevelModel({
    this.level,
    this.episodeId,
    this.creatureTypes,
  }) : super(
          level: level,
          episodeId: episodeId,
          creatureTypes: creatureTypes,
        );

  final int? level;
  final int? episodeId;
  final List<CreatureType>? creatureTypes;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => LevelModel(
        level: json["level"] == null ? null : json["level"],
        episodeId: json["episodeId"] == null ? null : json["episodeId"],
        creatureTypes: json["creatureTypes"] == null
            ? null
            : List<CreatureType>.from(
                json["creatureTypes"].map((x) => CreatureType.values[x])),
      );

  Map<String, dynamic> toJson() => {
        "level": level == null ? null : level,
        "episodeId": episodeId == null ? null : episodeId,
        "creatureTypes": creatureTypes == null
            ? null
            : List<dynamic>.from(creatureTypes?.map((x) => x.index) ?? []),
      };
}
