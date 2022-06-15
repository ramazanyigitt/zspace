import 'package:flutter/material.dart';
import 'package:zspace/features/home/inventory/inventory_viewmodel.dart';

import '../../../../shared/app_theme.dart';
import '../inventory_page.dart';
import 'default_box.dart';

class DraggedNewItemBox extends StatelessWidget {
  final SlideItem targetItem;
  final List<SlideItem?> items;
  final Widget defaultChild;
  final InventoryViewModel viewModel;
  const DraggedNewItemBox({
    Key? key,
    required this.targetItem,
    required this.items,
    required this.defaultChild,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.length > 0 && items[0]?.index != targetItem.index) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.95, end: 1),
        duration: Duration(milliseconds: 400),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Opacity(
          opacity: 0.7,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppTheme().primaryColor,
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: DefaultBox(
              key: GlobalKey(),
              item: items.first!,
              viewModel: viewModel,
              isLocked: false,
            ),
          ),
        ),
      );
    }
    return defaultChild;
  }
}
