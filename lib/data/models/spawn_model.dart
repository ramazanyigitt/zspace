import 'dart:convert';

import 'package:zspace/data/enums/creature_types.dart';

class SpawnModel {
  SpawnModel({
    this.position,
    this.type,
  });

  List<double>? position;
  CreatureType? type;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => SpawnModel(
        position: json["position"] == null
            ? null
            : List<double>.from(json["position"].map((x) => x.toDouble())),
        type: json["type"] == null ? null : CreatureType.values[json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "position": position == null
            ? null
            : List<dynamic>.from(position?.map((x) => x) ?? []),
        "type": type == null ? null : type?.index,
      };
}
