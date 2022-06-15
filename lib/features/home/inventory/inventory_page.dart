import 'dart:developer';
import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/features/_components/overlay/lock_overlay.dart';
import 'package:zspace/features/_components/theme_button.dart';
import 'package:zspace/features/home/inventory/inventory_viewmodel.dart';
import 'package:zspace/features/home/inventory/widgets/draggable_itembox.dart';
import 'package:zspace/features/home/inventory/widgets/dragged_new_itembox.dart';
import 'package:zspace/features/home/inventory/widgets/target_box_wrapper.dart';
import '../../../core/utils/lottie/lottie_cache.dart';
import '../../../domain/entities/inventory_item.dart';
import '../../../injection_container.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'ship_inventory.dart';
part 'player_inventory.dart';
part 'ship_view.dart';
part 'ship_change_view.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InventoryViewModel>.reactive(
      viewModelBuilder: () => InventoryViewModel(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppTheme().blackColor,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: locator<LottieCache>().load(
                    AppImages.spaceBackground.appLottie,
                    Container(),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return RadialGradient(
                        center: Alignment.topLeft,
                        radius: 2.67,
                        colors: <Color>[
                          Colors.yellow.withAlpha(100),
                          Colors.black.withAlpha(40)
                        ],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
                if (!viewModel.isInited)
                  Container(
                    height: 1.sh,
                    child: Center(
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme().darkPrimaryColor,
                          ),
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  ),
                if (viewModel.isInited)
                  Column(
                    children: [
                      _ShipInventory(
                        viewModel: viewModel,
                      ),
                      Expanded(
                        child: _PlayerInventory(
                          viewModel: viewModel,
                        ),
                      ),
                    ],
                  ),
                /*NestedScrollView(
                  controller: viewModel.scrollController,
                  body: _PlayerInventory(
                    viewModel: viewModel,
                  ),
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        collapsedHeight: 400,
                        expandedHeight: 400,
                        //floating: false,
                        pinned: true,
                        //snap: false,
                        backgroundColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: [
                            StretchMode.zoomBackground,
                            StretchMode.blurBackground,
                            StretchMode.fadeTitle,
                          ],
                          background: _ShipInventory(
                            viewModel: viewModel,
                          ),
                        ),
                        elevation: 0,
                        forceElevated: false,
                      ),
                    ];
                  },
                ),*/
              ],
            ),
          ),
        );
      },
    );
  }
}
