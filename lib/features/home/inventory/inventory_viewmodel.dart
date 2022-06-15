import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/data/enums/win_point_category.dart';

import '../../../domain/entities/inventory_item.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';
import 'inventory_page.dart';

class InventoryViewModel extends BaseViewModel {
  late List<SlideItem> inventoryItems, tempList;
  late List<InventoryItem> ships;

  late ValueNotifier<int?> selectingIndex;
  late int? selectedIndex;
  late ScrollController scrollController;
  late bool isInited;

  init() async {
    isInited = false;
    selectingIndex = ValueNotifier<int?>(null);
    selectedIndex = null;
    inventoryItems = [];
    ships = [];
    int index = 0;
    /*Colors.accents.forEach((element) {
      inventoryItems.add(
        SlideItem(
          index,
          Color(element.value),
          '$index',
        ),
      );
      index += 1;
    });
    Colors.primaries.forEach((element) {
      inventoryItems.add(
        SlideItem(
          index,
          Color(element.value),
          '$index',
        ),
      );
      index += 1;
    });*/

    tempList = List.from(inventoryItems);
    scrollController = ScrollController();
    await getInventory();
    isInited = true;
    notifyListeners();
  }

  void updateView() {
    notifyListeners();
  }

  Future getInventory() async {
    final data = await locator<DataRepository>().getInventory();
    if (data is Right) {
      final List<InventoryItem> allItems = (data as Right).value;
      for (int i = 0; i < 6; i++) {
        inventoryItems.add(
          SlideItem(
            i,
          ),
        );
      }
      final List<InventoryItem> equippedItems = List<InventoryItem>.from(
          allItems.where((element) => element.isEquipped!));
      equipItems(equippedItems);

      final List<InventoryItem> unEquippedItems = List<InventoryItem>.from(
        allItems.where(
          (element) =>
              !element.isEquipped! &&
              element.item!.category != MarketCategory.Ship.name,
        ),
      );
      for (InventoryItem inventoryItem in unEquippedItems) {
        inventoryItems.add(
          SlideItem(
            inventoryItems.length,
            inventoryItem: inventoryItem,
          ),
        );
      }
      if (unEquippedItems.length % 4 != 0) {
        for (int i = 0; i < 4 - (unEquippedItems.length % 4); i++) {
          inventoryItems.add(
            SlideItem(
              inventoryItems.length,
            ),
          );
        }
      }
      for (int i = 0; i < 8; i++) {
        inventoryItems.add(
          SlideItem(
            inventoryItems.length,
          ),
        );
      }

      ships = List<InventoryItem>.from(
        allItems.where(
          (element) => element.item!.category == MarketCategory.Ship.name,
        ),
      );
      log('ships: ${ships.length}');
    } else {
      //inventoryItems = [];
    }
  }

  void equipItems(List<InventoryItem> equippedItems) {
    for (InventoryItem inventoryItem in equippedItems) {
      if (inventoryItem.item?.category == MarketCategory.Weapon.name) {
        inventoryItems[0].inventoryItem = inventoryItem;
      } else if (inventoryItem.item?.category == MarketCategory.Weapon.name) {
        inventoryItems[1].inventoryItem = inventoryItem;
      } else if (inventoryItem.item?.category ==
          MarketCategory.EnergyGenerator.name) {
        inventoryItems[2].inventoryItem = inventoryItem;
      } else if (inventoryItem.item?.category ==
          MarketCategory.ShieldGenerator.name) {
        inventoryItems[3].inventoryItem = inventoryItem;
      } else if (inventoryItem.item?.category == MarketCategory.Ship.name) {
        //
      }
    }
  }

  Future<void> equipItem(InventoryItem? equipItem,
      {InventoryItem? unEquipItem}) async {
    log('Sending equip messages with $equipItem and $unEquipItem');
    await Future.wait(
      [
        if (unEquipItem != null)
          locator<DataRepository>().unEquipItem(unEquipItem.id!),
        if (equipItem != null)
          locator<DataRepository>().equipItem(equipItem.id!),
      ],
    );
    if (unEquipItem != null) {
      unEquipItem.isEquipped = false;
    }
    if (equipItem != null) {
      equipItem.isEquipped = true;
    }
  }
}

class SlideItem {
  int index;
  bool isDragging;
  InventoryItem? inventoryItem;

  SlideItem(
    this.index, {
    this.isDragging: false,
    this.inventoryItem,
  });
}
