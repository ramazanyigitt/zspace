import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GridTest extends StatefulWidget {
  const GridTest({Key? key}) : super(key: key);

  @override
  State<GridTest> createState() => _GridTestState();
}

class _GridTestState extends State<GridTest> {
  late List<Item> inventoryItems, tempList;

  late ValueNotifier<int?> selectingIndex;
  late int? selectedIndex;
  late ScrollController _scrollController;
  @override
  void initState() {
    selectingIndex = ValueNotifier<int?>(null);
    selectedIndex = null;
    inventoryItems = [];
    int index = 0;
    Colors.accents.forEach((element) {
      inventoryItems.add(
        Item(
          index,
          Color(element.value),
          '$index',
        ),
      );
      index += 1;
    });
    Colors.primaries.forEach((element) {
      inventoryItems.add(
        Item(
          index,
          Color(element.value),
          '$index',
        ),
      );
      index += 1;
    });
    tempList = List.from(inventoryItems);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          body: buildPlayerInventory(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                collapsedHeight: 350,
                expandedHeight: 350,
                //floating: false,
                pinned: true,
                //snap: false,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: buildShipInventory(),
                ),
              ),
            ];
          },
        ),
      ),
    );
  }

  _moveUp() {
    _scrollController.animateTo(
        _scrollController.offset - _scrollController.initialScrollOffset,
        curve: Curves.linear,
        duration: Duration(milliseconds: 500));
  }

  _moveDown() {
    _scrollController.animateTo(
        _scrollController.offset + _scrollController.position.maxScrollExtent,
        curve: Curves.linear,
        duration: Duration(milliseconds: 500));
  }

  Widget buildGreyBox() {
    return Container(
      color: Colors.grey,
      height: 100,
      width: 100,
    );
  }

  Widget buildShipInventory() {
    return Container(
      width: 300,
      height: 350,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              draggableItemBox(inventoryItems[0]),
              draggableItemBox(inventoryItems[1]),
              draggableItemBox(inventoryItems[2]),
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 150,
              height: double.infinity,
              color: Colors.yellow,
              child: Center(
                child: Text('Ship view'),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              draggableItemBox(inventoryItems[3]),
              draggableItemBox(inventoryItems[4]),
              draggableItemBox(inventoryItems[5]),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPlayerInventory() {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        print('Overrr');
        overscroll.disallowGlow();
        return true;
      },
      child: GridView.builder(
        itemCount: inventoryItems.length - 6,
        itemBuilder: (context, index) {
          final item = inventoryItems[index + 6];
          item.index = index + 6;
          return draggableItemBox(item);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 8,
        ),
      ),
    );
  }

  Widget draggableItemBox(Item item) {
    return wrapWithDragTargetBoxBuilder(
      targetItem: item,
      child: LongPressDraggable<Item>(
        delay: Duration(milliseconds: 150),
        maxSimultaneousDrags: 1,
        data: item,
        //dragAnchorStrategy: pointerDragAnchorStrategy,
        onDragStarted: () {
          item.isDragging = true;
        },
        onDragEnd: (data) {
          item.isDragging = false;
        },
        onDragCompleted: () {
          item.isDragging = false;
        },
        onDragUpdate: (data) {
          //item.isDragging = true;
        },
        onDraggableCanceled: (velocity, offset) {
          setState(() {});
          item.isDragging = false;
        },
        feedback: Transform.scale(
          scale: 0.75,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 100,
              height: 100,
              color: item.color,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Index: ${item.index}',
                    ),
                    Text(
                      'Text ${item.text}',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        childWhenDragging: ValueListenableBuilder(
          valueListenable: selectingIndex,
          builder: (context, value, child) {
            log('Selecting index: ${selectingIndex.value} selected: $selectedIndex');

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              reverseDuration: Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: selectedIndex == item.index
                  ? Container(
                      width: 100,
                      height: 100,
                      color: inventoryItems[selectingIndex.value!].color,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Index: ${inventoryItems[selectingIndex.value!].index}',
                            ),
                            Text(
                              'Text ${inventoryItems[selectingIndex.value!].text}',
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      key: GlobalKey(),
                      color: Colors.grey,
                      width: 100,
                      height: 100,
                    ),
            );
          },
        ),
        child: Container(
          width: 100,
          height: 100,
          color: item.color,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Index: ${item.index}',
                ),
                Text(
                  'Text ${item.text}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget wrapWithDragTargetBoxBuilder(
      {required Item targetItem, required Widget child}) {
    return DragTarget<Item>(
      builder: (context, candidateData, rejectedData) {
        return buildDraggedNewItemBox(
            targetItem: targetItem, items: candidateData, defaultChild: child);
      },
      onAccept: (item) {
        print('Accepted index: ${item.index} ti ${targetItem.index}');

        final targetItemIndex = targetItem.index;
        targetItem.index = item.index;
        item.index = targetItemIndex;
        inventoryItems[targetItem.index] = targetItem;
        inventoryItems[item.index] = item;
        selectingIndex.value = null;
        setState(() {});
        return;
      },
      onWillAccept: (item) {
        print('Accepting index: ${item?.index} ti ${targetItem.index}');
        selectedIndex = item!.index;
        selectingIndex.value = targetItem.index;
        log('Selecting index: ${selectingIndex.value} selected: $selectedIndex');
        return true;
      },
      onLeave: (item) {
        selectedIndex = null;
        selectingIndex.value = null;
        log('Selecting index: ${selectingIndex.value} selected: $selectedIndex');
        print(
            'Test item leave: ${item?.index} and my index: ${targetItem.index}');
      },
    );
  }

  Widget buildDraggedNewItemBox(
      {required Item targetItem,
      required List<Item?> items,
      required Widget defaultChild}) {
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
              color: items.first!.color,
              boxShadow: [
                BoxShadow(
                  color: Colors.pink,
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            width: 100,
            height: 100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Index: ${items.first!.index}',
                  ),
                  Text(
                    'Text ${items.first!.text}',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return defaultChild;
  }
}

class Item {
  final Color color;
  final String text;
  int index;
  bool isDragging;

  Item(this.index, this.color, this.text, {this.isDragging: false});
}
