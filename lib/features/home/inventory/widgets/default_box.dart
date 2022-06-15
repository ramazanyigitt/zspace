import 'package:flutter/material.dart';
import 'package:zspace/shared/app_images.dart';

import '../../../../shared/app_theme.dart';
import '../inventory_viewmodel.dart';

class DefaultBox extends StatelessWidget {
  final SlideItem item;
  final InventoryViewModel viewModel;
  final bool dragging;
  final bool removeBackground;
  final bool isLocked;
  const DefaultBox({
    Key? key,
    required this.item,
    required this.viewModel,
    this.dragging: false,
    this.removeBackground: false,
    required this.isLocked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: removeBackground ? Colors.transparent : AppTheme().blackColor,
      ),
      child: Center(
        child: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            image: (item.inventoryItem != null && !dragging)
                ? DecorationImage(
                    image: AssetImage(
                      item.inventoryItem!.item!.imageUrl!.appImage,
                    ),
                  )
                : null,
          ),
          child: isLocked
              ? Center(
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
