import 'dart:convert';

import '../../domain/entities/shield_generator.dart';

class ShieldGeneratorModel extends ShieldGenerator {
  ShieldGeneratorModel({
    this.id,
    this.shieldAmount,
    this.absorb,
    this.createdAt,
    this.updatedAt,
    this.itemId,
  }) : super(
          id: id,
          shieldAmount: shieldAmount,
          absorb: absorb,
          createdAt: createdAt,
          updatedAt: updatedAt,
          itemId: itemId,
        );

  final int? id;
  final int? shieldAmount;
  final int? absorb;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? itemId;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => ShieldGeneratorModel(
        id: json["id"] == null ? null : json["id"],
        shieldAmount:
            json["shieldAmount"] == null ? null : json["shieldAmount"],
        absorb: json["absorb"] == null ? null : json["absorb"],
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
        "shieldAmount": shieldAmount == null ? null : shieldAmount,
        "absorb": absorb == null ? null : absorb,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "itemId": itemId == null ? null : itemId,
      };
}
