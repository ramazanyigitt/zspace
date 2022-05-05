import 'package:equatable/equatable.dart';

class EnergyGenerator extends Equatable {
  EnergyGenerator({
    this.id,
    this.shipSpeed,
    this.createdAt,
    this.updatedAt,
    this.itemId,
  });

  final int? id;
  final int? shipSpeed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? itemId;

  @override
  List<Object?> get props => [
        id,
        shipSpeed,
        createdAt,
        updatedAt,
        itemId,
      ];
}
