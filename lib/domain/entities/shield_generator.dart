import 'package:equatable/equatable.dart';

class ShieldGenerator extends Equatable {
  ShieldGenerator({
    this.id,
    this.shieldAmount,
    this.absorb,
    this.createdAt,
    this.updatedAt,
    this.itemId,
  });

  final int? id;
  final int? shieldAmount;
  final int? absorb;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? itemId;

  @override
  List<Object?> get props => [
        id,
        shieldAmount,
        absorb,
        createdAt,
        updatedAt,
        itemId,
      ];
}
