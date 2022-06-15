import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zspace/features/home/inventory/widgets/default_box.dart';

import '../inventory_page.dart';
import '../inventory_viewmodel.dart';
import 'target_box_wrapper.dart';

class DraggableItemBox extends StatefulWidget {
  final SlideItem item;
  final InventoryViewModel viewModel;
  final bool isLocked;
  const DraggableItemBox({
    Key? key,
    required this.item,
    required this.viewModel,
    this.isLocked: false,
  }) : super(key: key);

  @override
  State<DraggableItemBox> createState() => _DraggableItemBoxState();
}

class _DraggableItemBoxState extends State<DraggableItemBox> {
  @override
  Widget build(BuildContext context) {
    return TargetBoxWrapper(
      viewModel: widget.viewModel,
      targetItem: widget.item,
      child: (widget.item.inventoryItem != null && !widget.isLocked)
          ? LongPressDraggable<SlideItem>(
              delay: Duration(milliseconds: 150),
              maxSimultaneousDrags: 1,
              data: widget.item,
              //dragAnchorStrategy: pointerDragAnchorStrategy,
              onDragStarted: () {
                widget.item.isDragging = true;
              },
              onDragEnd: (data) {
                widget.item.isDragging = false;
              },
              onDragCompleted: () {
                widget.item.isDragging = false;
              },
              onDragUpdate: (data) {
                //item.isDragging = true;
              },
              onDraggableCanceled: (velocity, offset) {
                //TODO??
                setState(() {});
                widget.item.isDragging = false;
              },
              feedback: Transform.scale(
                scale: 0.75,
                child: Material(
                  color: Colors.transparent,
                  child: DefaultBox(
                    item: widget.item,
                    viewModel: widget.viewModel,
                    removeBackground: true,
                    isLocked: widget.isLocked,
                  ),
                ),
              ),

              childWhenDragging: ValueListenableBuilder<int?>(
                valueListenable: widget.viewModel.selectingIndex,
                builder: (context, value, child) {
                  log('Selecting index: ${widget.viewModel.selectingIndex.value} selected: ${widget.viewModel}.selectedIndex');

                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    reverseDuration: Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: widget.viewModel.selectedIndex == widget.item.index
                        ? DefaultBox(
                            key: GlobalKey(),
                            item: widget.viewModel
                                .inventoryItems[value ?? widget.item.index],
                            viewModel: widget.viewModel,
                            isLocked: widget.isLocked,
                            //dragging: true,
                          )
                        /*Container(
                            width: 100,
                            height: 100,
                            color: Colors
                                .grey /*widget
                          .viewModel
                          .inventoryItems[
                              widget.viewModel.selectingIndex.value!]
                          .color*/
                            ,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Index: ${widget.viewModel.inventoryItems[widget.viewModel.selectingIndex.value!].index}',
                                  ),
                                  Text(
                                    'Text ${widget.viewModel.inventoryItems[widget.viewModel.selectingIndex.value!].inventoryItem?.item?.name}',
                                  ),
                                ],
                              ),
                            ),
                          )*/
                        : DefaultBox(
                            key: GlobalKey(),
                            item: widget.item,
                            viewModel: widget.viewModel,
                            dragging: true,
                            isLocked: widget.isLocked,
                          ),
                  );
                },
              ),
              child: DefaultBox(
                item: widget.item,
                viewModel: widget.viewModel,
                isLocked: widget.isLocked,
              ), /*Container(
                width: 100,
                height: 100,
                color: Colors.grey, //widget.item.color,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Index: ${widget.item.index}',
                      ),
                      Text(
                        'Text ${widget.item.inventoryItem?.item?.name}',
                      ),
                    ],
                  ),
                ),
              ),*/
            )
          : DefaultBox(
              item: widget.item,
              viewModel: widget.viewModel,
              isLocked: widget.isLocked,
            ),
    );
  }
}
