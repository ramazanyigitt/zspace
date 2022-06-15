import 'dart:convert';

import 'market_item_model.dart';
import '../../domain/entities/inventory_item.dart';

class InventoryItemModel extends InventoryItem {
  InventoryItemModel({
    this.id,
    this.itemId,
    this.userId,
    this.isEquipped,
    this.createdAt,
    this.updatedAt,
    this.item,
  }) : super(
          id: id,
          itemId: itemId,
          userId: userId,
          isEquipped: isEquipped,
          createdAt: createdAt,
          updatedAt: updatedAt,
          item: item,
        );

  final int? id;
  final int? itemId;
  final int? userId;
  bool? isEquipped;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final MarketItemModel? item;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => InventoryItemModel(
        id: json["id"] == null ? null : json["id"],
        itemId: json["itemId"] == null ? null : json["itemId"],
        userId: json["userId"] == null ? null : json["userId"],
        isEquipped: json["isEquipped"] == null ? null : json["isEquipped"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        item: json["item"] == null
            ? null
            : MarketItemModel().fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "itemId": itemId == null ? null : itemId,
        "userId": userId == null ? null : userId,
        "isEquipped": isEquipped == null ? null : isEquipped,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "item": item == null ? null : item?.toJson(),
      };
}
