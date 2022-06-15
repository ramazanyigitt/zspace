import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/features/shop/market_item_detail/buy_dialog.dart';

import '../../../core/errors/failure.dart';
import '../../../data/models/market_item_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import '../../_components/overlay/lock_overlay.dart';
import '../../_components/overlay/lock_overlay_dialog.dart';
import '../../_components/overlay/snackbar_overlay.dart';
import '../../_components/overlay/widgets/custom_dialog.dart';

class ProductDetailViewModel extends BaseViewModel {
  late bool isInited;

  Future<void> init() async {
    isInited = false;

    isInited = true;
    notifyListeners();
  }

  /// Show user the trade dialog
  /// If not logged prevent and show a dialog for log in.
  Future<dynamic> showTrade(
    BuildContext context,
    MarketItemModel marketItem,
  ) async {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) => BuyDialog(
        marketItem: marketItem,
        button1Text: 'Trade',
        button2Text: 'Cancel',
        onClickOutside: () {},
        onButton1Tap: (int amount) {
          trade(marketItem, amount);
          Navigator.of(context).pop();
        },
        onButton2Tap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  /// When click trade button from dialog, this method will be called
  /// And will trade the item with amount as given by user
  /// Then will request for points from backend and update the UI
  /// If success will show a dialog about 'success' with gif
  /// If not will show a ui with error message
  Future<void> trade(MarketItemModel marketItem, int amount) async {
    LockOverlay().showClassicLoadingOverlay(buildAfterRebuild: true);
    final result = await locator<DataRepository>().buyItem(marketItem.id!);
    LockOverlay().closeOverlay();
    if (result is Right) {
      LockOverlayDialog().showCustomOverlay(
        child: CustomDialog(
          titleText: 'Purchase Successful',
          descriptionText: 'You have successfully purchased ${marketItem.name}',
          button1Text: 'Done',
          button2Text: 'Cancel',
          image: 'giphy.gif',
          onButton1Tap: () {
            LockOverlayDialog().closeOverlay();
          },
          disableCancelButton: true,
        ),
      );
    } else {
      if ((result as Left).value is ServerFailure) {
        SnackbarOverlay().show(
          text: '${((result as Left).value as ServerFailure).errorMessage}',
          buttonText: 'OK',
          buttonTextColor: Colors.red,
          addFrameCallback: true,
          onTap: () {
            SnackbarOverlay().closeCustomOverlay();
          },
          removeDuration: Duration(seconds: 10),
          forceOverlay: true,
        );
      } else {
        SnackbarOverlay().show(
          text: '${(result as Left).value.toString()}',
          buttonText: 'OK',
          buttonTextColor: Colors.red,
          addFrameCallback: true,
          onTap: () {
            SnackbarOverlay().closeCustomOverlay();
          },
          removeDuration: Duration(seconds: 10),
          forceOverlay: true,
        );
      }
    }
    notifyListeners();
  }
}
