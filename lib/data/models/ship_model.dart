import 'dart:convert';

import '../../domain/entities/ship.dart';

class ShipModel extends Ship {
  ShipModel({
    this.id,
    this.armor,
    this.speed,
    this.power,
    this.shield,
    this.attack,
    this.createdAt,
    this.updatedAt,
    this.itemId,
  }) : super(
          id: id,
          armor: armor,
          speed: speed,
          power: power,
          shield: shield,
          attack: attack,
          createdAt: createdAt,
          updatedAt: updatedAt,
          itemId: itemId,
        );

  final int? id;
  final int? armor;
  final int? speed;
  final int? power;
  final int? shield;
  final int? attack;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? itemId;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => ShipModel(
        id: json["id"] == null ? null : json["id"],
        armor: json["armor"] == null ? null : json["armor"],
        speed: json["speed"] == null ? null : json["speed"],
        power: json["power"] == null ? null : json["power"],
        shield: json["shield"] == null ? null : json["shield"],
        attack: json["attack"] == null ? null : json["attack"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        itemId: json["itemId"] == null ? null : json["itemId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "armor": armor == null ? null : armor,
        "speed": speed == null ? null : speed,
        "power": power == null ? null : power,
        "shield": shield == null ? null : shield,
        "attack": attack == null ? null : attack,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "itemId": itemId == null ? null : itemId,
      };
}
