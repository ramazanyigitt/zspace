import 'dart:convert';

import 'package:equatable/equatable.dart';
import '../../data/models/market_item_model.dart';

class InventoryItem extends Equatable {
  InventoryItem({
    this.id,
    this.itemId,
    this.userId,
    this.isEquipped,
    this.createdAt,
    this.updatedAt,
    this.item,
  });

  final int? id;
  final int? itemId;
  final int? userId;
  final bool? isEquipped;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final MarketItemModel? item;

  @override
  List<Object?> get props => [
        id,
        itemId,
        userId,
        isEquipped,
        createdAt,
        updatedAt,
        item,
      ];
}
