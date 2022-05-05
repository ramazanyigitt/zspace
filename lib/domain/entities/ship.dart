import 'package:equatable/equatable.dart';

class Ship extends Equatable {
  Ship({
    this.id,
    this.armor,
    this.speed,
    this.power,
    this.shield,
    this.attack,
    this.createdAt,
    this.updatedAt,
    this.itemId,
  });

  final int? id;
  final int? armor;
  final int? speed;
  final int? power;
  final int? shield;
  final int? attack;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? itemId;

  @override
  List<Object?> get props => [
        id,
        armor,
        speed,
        power,
        shield,
        attack,
        createdAt,
        updatedAt,
        itemId,
      ];
}
