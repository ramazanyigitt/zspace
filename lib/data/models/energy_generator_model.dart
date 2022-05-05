import 'dart:convert';

import 'package:zspace/domain/entities/energy_generator.dart';

class EnergyGeneratorModel extends EnergyGenerator {
  EnergyGeneratorModel({
    this.id,
    this.shipSpeed,
    this.createdAt,
    this.updatedAt,
    this.itemId,
  }) : super(
          id: id,
          shipSpeed: shipSpeed,
          createdAt: createdAt,
          updatedAt: updatedAt,
          itemId: itemId,
        );

  final int? id;
  final int? shipSpeed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? itemId;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => EnergyGeneratorModel(
        id: json["id"] == null ? null : json["id"],
        shipSpeed: json["shipSpeed"] == null ? null : json["shipSpeed"],
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
        "shipSpeed": shipSpeed == null ? null : shipSpeed,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "itemId": itemId == null ? null : itemId,
      };
}
