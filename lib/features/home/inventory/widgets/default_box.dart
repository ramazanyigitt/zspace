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
    return Stack(
      children: [
        if (!removeBackground)
          Container(
            width: 80,
            height: 80,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: 70,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(0.35),
                ),
              ),
            ),
          ),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: removeBackground
                ? null
                : DecorationImage(
                    image: AssetImage(
                      AppImages.items.frame.appImage,
                    ),
                    colorFilter: ColorFilter.matrix(<double>[
                      0.393,
                      0.45,
                      0.089,
                      0,
                      0,
                      0.349,
                      0.686,
                      0.868,
                      0.1,
                      0,
                      0.272,
                      0.534,
                      2,
                      0,
                      0,
                      0,
                      0,
                      1,
                      1,
                      0,
                    ]),
                  ),
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
        ),
      ],
    );
  }
}
