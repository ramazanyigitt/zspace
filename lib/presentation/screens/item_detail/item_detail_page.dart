import 'package:flutter/material.dart';
import 'package:zspace/presentation/screens/item_detail/item_detail_viewmodel.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget buildBuyButton(String text, VoidCallback onPressed) {
    return RaisedButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }

  Widget animationForPurchased(BuildContext context) {
    return Container();
  }

  Widget animationForFail(BuildContext context) {
    return Container();
  }
}
