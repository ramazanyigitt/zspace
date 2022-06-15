import 'package:equatable/equatable.dart';

class Weapon extends Equatable {
  Weapon({
    this.id,
    this.damage,
    this.attackSpeed,
    this.createdAt,
    this.updatedAt,
    this.itemId,
  });

  final int? id;
  final num? damage;
  final num? attackSpeed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? itemId;

  @override
  List<Object?> get props => [
        id,
        damage,
        attackSpeed,
        createdAt,
        updatedAt,
        itemId,
      ];
}
