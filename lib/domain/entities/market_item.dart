import 'package:equatable/equatable.dart';

import 'energy_generator.dart';
import 'level.dart';
import 'shield_generator.dart';
import 'ship.dart';
import 'weapon.dart';

class MarketItem extends Equatable {
  MarketItem({
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
  });

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
  final Weapon? weapon;
  final EnergyGenerator? energyGenerator;
  final ShieldGenerator? shieldGenerator;
  final Ship? ship;
  final Level? level;

  @override
  List<Object?> get props => [
        id,
        name,
        buyPrice,
        sellPrice,
        stock,
        isActive,
        isSalable,
        description,
        imageUrl,
        levelId,
        createdAt,
        updatedAt,
        category,
        weapon,
        energyGenerator,
        shieldGenerator,
        ship,
        level,
      ];
}
