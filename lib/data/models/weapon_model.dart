import 'dart:convert';

import '../../domain/entities/weapon.dart';

class WeaponModel extends Weapon {
  WeaponModel({
    this.id,
    this.damage,
    this.attackSpeed,
    this.createdAt,
    this.updatedAt,
    this.itemId,
  }) : super(
          id: id,
          damage: damage,
          attackSpeed: attackSpeed,
          createdAt: createdAt,
          updatedAt: updatedAt,
          itemId: itemId,
        );

  final int? id;
  final int? damage;
  final int? attackSpeed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? itemId;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => WeaponModel(
        id: json["id"] == null ? null : json["id"],
        damage: json["damage"] == null ? null : json["damage"],
        attackSpeed: json["attackSpeed"] == null ? null : json["attackSpeed"],
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
        "damage": damage == null ? null : damage,
        "attackSpeed": attackSpeed == null ? null : attackSpeed,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "itemId": itemId == null ? null : itemId,
      };
}
