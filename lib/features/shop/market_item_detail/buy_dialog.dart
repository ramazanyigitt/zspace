import 'package:flutter/material.dart';
import 'package:zspace/data/models/market_item_model.dart';

import '../../../../shared/app_theme.dart';
import '../../_components/theme_button.dart';

class BuyDialog extends StatefulWidget {
  final String button1Text, button2Text;
  final Function(int amount) onButton1Tap;
  final Function()? onButton2Tap, onResume, onClickOutside;
  final MarketItemModel marketItem;
  const BuyDialog({
    Key? key,
    this.button1Text = '',
    this.button2Text = '',
    required this.onButton1Tap,
    this.onButton2Tap,
    this.onResume,
    this.onClickOutside,
    required this.marketItem,
  }) : super(key: key);

  @override
  State<BuyDialog> createState() => _BuyDialogState();
}

class _BuyDialogState extends State<BuyDialog> {
  late int credit;
  @override
  void initState() {
    credit = widget.marketItem.buyPrice ?? 1;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onClickOutside != null) widget.onClickOutside!();
        Navigator.of(context).pop();
      },
      child: Material(
        color: AppTheme().blackColor.withOpacity(0.55),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Are you sure?',
                      style: AppTheme().paragraphSemiBoldText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      'You are buying ${widget.marketItem.name} in exchange for ${credit} credits.',
                      style: AppTheme().smallParagraphRegularText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        ThemeButton(
                          color: AppTheme().darkPrimaryColor,
                          height: 42,
                          onTap: () {
                            widget.onButton1Tap(credit);
                          },
                          text: 'Buy',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ThemeButton(
                          height: 42,
                          color: Colors.transparent,
                          textColor: Colors.black,
                          isEnabled: false,
                          elevation: 0,
                          onTap: () {
                            if (widget.onButton2Tap != null)
                              widget.onButton2Tap!();
                          },
                          text: widget.button2Text,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget basketAmountButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '1 ${widget.marketItem.name}',
            style: AppTheme().paragraphRegularText.copyWith(
                  fontSize: AppTheme().paragraphRegularText.fontSize! * 1.25,
                ),
          ),
        ],
      ),
    );
  }
}
