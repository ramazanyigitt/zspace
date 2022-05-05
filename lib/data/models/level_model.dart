import 'dart:convert';

import 'package:zspace/domain/entities/level.dart';

class LevelModel extends Level {
  LevelModel({
    this.level,
    this.episodeId,
  }) : super(
          level: level,
          episodeId: episodeId,
        );

  final int? level;
  final int? episodeId;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => LevelModel(
        level: json["level"] == null ? null : json["level"],
        episodeId: json["episodeId"] == null ? null : json["episodeId"],
      );

  Map<String, dynamic> toJson() => {
        "level": level == null ? null : level,
        "episodeId": episodeId == null ? null : episodeId,
      };
}
