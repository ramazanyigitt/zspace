import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:nine_grid_view/nine_grid_view.dart';
import 'package:reorderable_griditem_view/reorderable_griditem_view.dart';

class GridTest extends StatefulWidget {
  const GridTest({Key? key}) : super(key: key);

  @override
  State<GridTest> createState() => _GridTestState();
}

class _GridTestState extends State<GridTest> {
  late List<Item> inventoryItems, tempList;

  late ValueNotifier<int?> pos;
  @override
  void initState() {
    pos = ValueNotifier<int?>(null);
    inventoryItems = [];
    int index = 0;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildShipInventory(),
            Expanded(child: buildPlayerInventory()),
          ],
        ),
      ),
    );
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
      height: 300,
      child: Row(
        children: [
          Column(
            children: [
              draggableItemBox(inventoryItems[0]),
              draggableItemBox(inventoryItems[1]),
              draggableItemBox(inventoryItems[2]),
            ],
          ),
          Expanded(
            child: Container(
              width: 150,
              height: double.infinity,
              color: Colors.yellow,
              child: Center(
                child: Text('Ship view'),
              ),
            ),
          ),
          Column(
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
    return GridView.builder(
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
    );
  }

  Widget draggableItemBox(Item item) {
    return wrapWithDragTargetBoxBuilder(
      targetItem: item,
      child: Draggable<Item>(
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
        /*childWhenDragging: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
        ),*/
        child: ValueListenableBuilder(
          valueListenable: pos.value != inventoryItems.indexOf(item)
              ? ValueNotifier<int?>(null)
              : pos,
          builder: (context, value, child) {
            return Opacity(
              opacity: pos.value != null
                  ? pos.value == inventoryItems.indexOf(item)
                      ? 0.6
                      : 1
                  : 1,
              child: child,
            );
          },
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
        //print('- Removing index: ${item.index}');
        //print('- Adding index: ${targetItem.index}');
        if (targetItem.index > 5) {
          inventoryItems.removeAt(item.index);
          inventoryItems.insert(targetItem.index, item);
        } else {
          final targetItemIndex = targetItem.index;
          targetItem.index = item.index;
          item.index = targetItemIndex;
          inventoryItems[targetItem.index] = targetItem;
          inventoryItems[item.index] = item;
          setState(() {});
          return;
        }
        //inventoryItems.removeAt(item.index);
        //inventoryItems.insert(targetItem.index, item);

        //updateReorder(targetItem.index, item.index);
        //updateReorder(item.index, targetItem.index);
        tempList = List.from(inventoryItems);
        pos.value = null;
        setState(() {});
      },
      onWillAccept: (item) {
        //print('Accepting index: ${item?.index} ti ${targetItem.index}');
        if (targetItem.index <= 5) {
          print(
              '${DateTime.now().millisecondsSinceEpoch} target index: ${targetItem.index}');
          inventoryItems = List.from(tempList);
          setState(
            () {},
          );
          return true;
        }

        //inventoryItems = List.from(tempList);
        int indexOfFirstItem = inventoryItems.indexOf(item!);
        int indexOfSecondItem = inventoryItems.indexOf(targetItem);
        print(
            '${DateTime.now().second} Accepting index 2: fi $indexOfFirstItem si $indexOfSecondItem');
        print('Fi ${item.index} n: ${item.text}');
        print('Si ${targetItem.index} n: ${targetItem.text}');

        final newItem = inventoryItems.removeAt(indexOfFirstItem);
        inventoryItems.insert(indexOfSecondItem, newItem);

        pos.value = indexOfSecondItem;

        /*indexOfFirstItem = inventoryItems.indexOf(item);
        indexOfSecondItem = inventoryItems.indexOf(targetItem);
        item.index = indexOfFirstItem;
        targetItem.index = indexOfSecondItem;
        print(
            '${DateTime.now().second} AFFTER Accepting index 2: fi $indexOfFirstItem si $indexOfSecondItem');
        print('Fi ${item.index} n: ${item.text}');
        print('Si ${targetItem.index} n: ${targetItem.text}');*/

        setState(
          () {},
        );

        return true;
      },
      onLeave: (item) {
        pos.value = null;
        //inventoryItems = List.from(tempList);
        //setState(() {});
        print(
            'Test item leave: ${item?.index} and my index: ${targetItem.index}');
      },
    );
  }

  Widget buildDraggedNewItemBox(
      {required Item targetItem,
      required List<Item?> items,
      required Widget defaultChild}) {
    if (items.length > 0) {
      if (targetItem.index <= 5)
        return Container(
          width: 100,
          height: 100,
          color: items.first!.color,
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
