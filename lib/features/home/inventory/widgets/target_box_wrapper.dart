import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zspace/data/enums/win_point_category.dart';
import 'package:zspace/features/home/inventory/inventory_viewmodel.dart';

import '../inventory_page.dart';
import 'dragged_new_itembox.dart';

class TargetBoxWrapper extends StatefulWidget {
  final SlideItem targetItem;
  final Widget child;
  final InventoryViewModel viewModel;
  const TargetBoxWrapper({
    Key? key,
    required this.targetItem,
    required this.child,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<TargetBoxWrapper> createState() => _TargetBoxWrapperState();
}

class _TargetBoxWrapperState extends State<TargetBoxWrapper> {
  @override
  Widget build(BuildContext context) {
    return DragTarget<SlideItem>(
      builder: (context, candidateData, rejectedData) {
        return DraggedNewItemBox(
          targetItem: widget.targetItem,
          items: candidateData,
          defaultChild: widget.child,
          viewModel: widget.viewModel,
        );
      },
      onAccept: (item) {
        print('Accepted index: ${item.index} ti ${widget.targetItem.index}');

        if (widget.targetItem.index < 6) {
          widget.viewModel.equipItem(
            item.inventoryItem!,
            unEquipItem: widget.targetItem.inventoryItem,
          );
        } else if (item.index < 6) {
          log('Item of slided: ${item.inventoryItem?.item?.name}');
          widget.viewModel.equipItem(
            widget.targetItem.inventoryItem,
            unEquipItem: item.inventoryItem,
          );
        }

        final targetItemIndex = widget.targetItem.index;
        widget.targetItem.index = item.index;
        item.index = targetItemIndex;
        widget.viewModel.inventoryItems[widget.targetItem.index] =
            widget.targetItem;
        widget.viewModel.inventoryItems[item.index] = item;
        widget.viewModel.selectingIndex.value = null;

        //TODO
        setState(() {});
        widget.viewModel.updateView();
        return;
      },
      onWillAccept: (item) {
        if (item == null) return false;
        final bool cantChangeWithWeapon = item.index == 0 &&
            widget.targetItem.inventoryItem != null &&
            widget.targetItem.inventoryItem!.item!.category !=
                MarketCategory.Weapon.name;

        final bool cantChangeWithRocket = item.index == 1 &&
            widget.targetItem.inventoryItem != null &&
            widget.targetItem.inventoryItem!.item!.category !=
                MarketCategory.Weapon.name;

        final bool cantChangeWithSpeed = item.index == 2 &&
            widget.targetItem.inventoryItem != null &&
            widget.targetItem.inventoryItem!.item!.category !=
                MarketCategory.EnergyGenerator.name;

        final bool cantChangeWithShield = item.index == 3 &&
            widget.targetItem.inventoryItem != null &&
            widget.targetItem.inventoryItem!.item!.category !=
                MarketCategory.ShieldGenerator.name;

        if (widget.targetItem.index == 0) {
          if (item.inventoryItem?.item?.category !=
              MarketCategory.Weapon.name) {
            return false;
          }
        }
        if (widget.targetItem.index == 1) {
          if (item.inventoryItem?.item?.category !=
              MarketCategory.Weapon.name) {
            return false;
          }
        }
        if (widget.targetItem.index == 2) {
          log('Item category: ${item.inventoryItem?.item?.category}');
          if (item.inventoryItem?.item?.category !=
              MarketCategory.EnergyGenerator.name) {
            return false;
          }
        }
        if (widget.targetItem.index == 3) {
          if (item.inventoryItem?.item?.category !=
              MarketCategory.ShieldGenerator.name) {
            return false;
          }
        }
        if (widget.targetItem.index == 4 || widget.targetItem.index == 5) {
          return false;
        }
        if (cantChangeWithWeapon) {
          return false;
        } else if (cantChangeWithRocket) {
          return false;
        } else if (cantChangeWithSpeed) {
          return false;
        } else if (cantChangeWithShield) {
          return false;
        }
        log('Cant change with energy: $cantChangeWithSpeed');

        print('WAccepting index: ${item.index} ti ${widget.targetItem.index}');
        widget.viewModel.selectedIndex = item.index;
        widget.viewModel.selectingIndex.value = widget.targetItem.index;
        log('WSelecting index: ${widget.viewModel.selectingIndex.value} selected: ${widget.viewModel}.selectedIndex');
        return true;
      },
      onLeave: (item) {
        widget.viewModel.selectedIndex = null;
        widget.viewModel.selectingIndex.value = null;
        log('Selecting index: ${widget.viewModel.selectingIndex.value} selected: ${widget.viewModel}.selectedIndex');
        print(
            'Test item leave: ${item?.index} and my index: ${widget.targetItem.index}');
      },
    );
  }
}
