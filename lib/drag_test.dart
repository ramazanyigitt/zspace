import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _imageUris = [
    "https://images.pexels.com/photos/4466054/pexels-photo-4466054.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://images.pexels.com/photos/4561739/pexels-photo-4561739.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/4507967/pexels-photo-4507967.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/4321194/pexels-photo-4321194.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/1053924/pexels-photo-1053924.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/1624438/pexels-photo-1624438.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/1144687/pexels-photo-1144687.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/2589010/pexels-photo-2589010.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
  ];

  int? pos;

  late List<String> tmpList;
  int variableSet = 0;
  ScrollController? _scrollController;
  double? width;
  double? height;

  @override
  void initState() {
    tmpList = [..._imageUris];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vertical DragAndDropGridView Hover Effect'),
      ),
      body: Center(
        child: DragAndDropGridView(
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4.5,
          ),
          padding: EdgeInsets.all(20),
          itemBuilder: (context, index) => Opacity(
            opacity: pos != null
                ? pos == index
                    ? 0.6
                    : 1
                : 1,
            child: Card(
              elevation: 2,
              child: LayoutBuilder(builder: (context, costrains) {
                if (variableSet == 0) {
                  height = costrains.maxHeight;
                  width = costrains.maxWidth;
                  variableSet++;
                }
                return GridTile(
                  child: Image.network(
                    _imageUris[index],
                    fit: BoxFit.cover,
                    height: height,
                    width: width,
                  ),
                );
              }),
            ),
          ),
          itemCount: _imageUris.length,
          onWillAccept: (oldIndex, newIndex) {
            print('Wil Old index $oldIndex newIndex: $newIndex');
            _imageUris = [...tmpList];
            int indexOfFirstItem = _imageUris.indexOf(_imageUris[oldIndex]);
            int indexOfSecondItem = _imageUris.indexOf(_imageUris[newIndex]);

            if (indexOfFirstItem > indexOfSecondItem) {
              for (int i = _imageUris.indexOf(_imageUris[oldIndex]);
                  i > _imageUris.indexOf(_imageUris[newIndex]);
                  i--) {
                var tmp = _imageUris[i - 1];
                _imageUris[i - 1] = _imageUris[i];
                _imageUris[i] = tmp;
              }
            } else {
              for (int i = _imageUris.indexOf(_imageUris[oldIndex]);
                  i < _imageUris.indexOf(_imageUris[newIndex]);
                  i++) {
                var tmp = _imageUris[i + 1];
                _imageUris[i + 1] = _imageUris[i];
                _imageUris[i] = tmp;
              }
            }

            setState(
              () {
                pos = newIndex;
              },
            );
            return true;
          },
          onReorder: (oldIndex, newIndex) {
            print('Acce Old index $oldIndex newIndex: $newIndex');
            _imageUris = [...tmpList];
            int indexOfFirstItem = _imageUris.indexOf(_imageUris[oldIndex]);
            int indexOfSecondItem = _imageUris.indexOf(_imageUris[newIndex]);

            if (indexOfFirstItem > indexOfSecondItem) {
              for (int i = _imageUris.indexOf(_imageUris[oldIndex]);
                  i > _imageUris.indexOf(_imageUris[newIndex]);
                  i--) {
                var tmp = _imageUris[i - 1];
                _imageUris[i - 1] = _imageUris[i];
                _imageUris[i] = tmp;
              }
            } else {
              for (int i = _imageUris.indexOf(_imageUris[oldIndex]);
                  i < _imageUris.indexOf(_imageUris[newIndex]);
                  i++) {
                var tmp = _imageUris[i + 1];
                _imageUris[i + 1] = _imageUris[i];
                _imageUris[i] = tmp;
              }
            }
            tmpList = [..._imageUris];
            setState(
              () {
                pos = null;
              },
            );
          },
        ),
      ),
    );
  }
}
