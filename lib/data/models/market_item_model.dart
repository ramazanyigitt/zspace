import 'dart:convert';

import '../enums/win_point_category.dart';
import 'energy_generator_model.dart';
import 'level_model.dart';
import 'shield_generator_model.dart';
import 'ship_model.dart';
import 'weapon_model.dart';
import '../../domain/entities/market_item.dart';

class MarketItemModel extends MarketItem {
  MarketItemModel({
    this.id,
    this.name,
    this.buyPrice,
    this.sellPrice,
    this.stock,
    this.isActive,
    this.isSalable,
    this.description,
    this.imageUrl,
    this.levelId,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.weapon,
    this.energyGenerator,
    this.shieldGenerator,
    this.ship,
    this.level,
  }) : super(
          id: id,
          name: name,
          buyPrice: buyPrice,
          sellPrice: sellPrice,
          stock: stock,
          isActive: isActive,
          isSalable: isSalable,
          description: description,
          imageUrl: imageUrl,
          levelId: levelId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          category: category,
          weapon: weapon,
          energyGenerator: energyGenerator,
          shieldGenerator: shieldGenerator,
          ship: ship,
          level: level,
        );

  final int? id;
  final String? name;
  final int? buyPrice;
  final int? sellPrice;
  final int? stock;
  final bool? isActive;
  final bool? isSalable;
  final String? description;
  final String? imageUrl;
  final int? levelId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? category;
  final WeaponModel? weapon;
  final EnergyGeneratorModel? energyGenerator;
  final ShieldGeneratorModel? shieldGenerator;
  final ShipModel? ship;
  final LevelModel? level;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => MarketItemModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        buyPrice: json["buyPrice"] == null ? null : json["buyPrice"],
        sellPrice: json["sellPrice"] == null ? null : json["sellPrice"],
        stock: json["stock"] == null ? null : json["stock"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        isSalable: json["isSalable"] == null ? null : json["isSalable"],
        description: json["description"] == null ? null : json["description"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        levelId: json["levelId"] == null ? null : json["levelId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        category: json["category"] == null ? null : json["category"],
        weapon: json["weapon"] == null
            ? null
            : WeaponModel().fromJson(json["weapon"]),
        energyGenerator: json["energyGenerator"] == null
            ? null
            : EnergyGeneratorModel().fromJson(json["energyGenerator"]),
        shieldGenerator: json["shieldGenerator"] == null
            ? null
            : ShieldGeneratorModel().fromJson(json["shieldGenerator"]),
        ship: json["ship"] == null ? null : ShipModel().fromJson(json["ship"]),
        level:
            json["level"] == null ? null : LevelModel().fromJson(json["level"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "buyPrice": buyPrice == null ? null : buyPrice,
        "sellPrice": sellPrice == null ? null : sellPrice,
        "stock": stock == null ? null : stock,
        "isActive": isActive == null ? null : isActive,
        "isSalable": isSalable == null ? null : isSalable,
        "description": description == null ? null : description,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "levelId": levelId == null ? null : levelId,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "category": category == null ? null : category,
        "weapon": weapon == null ? null : weapon?.toJson(),
        "energyGenerator":
            energyGenerator == null ? null : energyGenerator?.toJson(),
        "shieldGenerator":
            shieldGenerator == null ? null : shieldGenerator?.toJson(),
        "ship": ship == null ? null : ship?.toJson(),
        "level": level == null ? null : level?.toJson(),
      };
}

extension CategoryExtension on MarketItemModel {
  bool get isShip {
    return category == MarketCategory.Ship.name;
  }

  bool get isWeapon {
    return category == MarketCategory.Weapon.name;
  }

  bool get isShieldGenerator {
    return category == MarketCategory.ShieldGenerator.name;
  }

  bool get isEnergyGenerator {
    return category == MarketCategory.EnergyGenerator.name;
  }

  String get getShipPath {
    return imageUrl!;
  }
}
