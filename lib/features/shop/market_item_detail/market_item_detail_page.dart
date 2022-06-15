import 'dart:developer';
import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zspace/shared/app_images.dart';
import '../../../data/models/market_item_model.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../_components/curved_container.dart';
import '../../_components/theme_button.dart';
import 'market_item_detail_viewmodel.dart';
import '../../../shared/app_theme.dart';

part 'top_bar.dart';

class MarketItemDetailPage extends StatefulWidget {
  final MarketItemModel marketItem;
  final String? heroTag;
  const MarketItemDetailPage({
    Key? key,
    required this.marketItem,
    this.heroTag,
  }) : super(key: key);

  @override
  State<MarketItemDetailPage> createState() => _MarketItemDetailPageState();
}

class _MarketItemDetailPageState extends State<MarketItemDetailPage> {
  late final CarouselController carouselController;
  late ValueNotifier<double?> dotPosition;
  @override
  void initState() {
    carouselController = CarouselController();
    dotPosition = ValueNotifier(0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        if (!viewModel.isInited) {
          return Center(
            child: Container(
              width: 64.w,
              height: 64.w,
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: AppTheme().primaryColor,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text('Detail'),
            centerTitle: true,
            actions: [],
          ),
          backgroundColor: AppTheme().whiteColor,
          body: Container(
            child: SafeArea(
              child: Stack(
                children: [
                  ListView(
                    children: [
                      buildImageBox(),
                      CurvedContainer(
                        radius: 20,
                        child: Container(
                          color: AppTheme().whiteColor,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 25.h,
                                ),
                                _TopBar(
                                  marketItem: widget.marketItem,
                                ),
                                Container(
                                  height: 16.h,
                                ),
                                Text(
                                  'Description',
                                  style: AppTheme()
                                      .smallParagraphMediumText
                                      .copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                                Container(
                                  height: 8.h,
                                ),
                                Text(
                                  widget.marketItem.description ?? '',
                                  style: AppTheme()
                                      .extraSmallParagraphRegularText
                                      .copyWith(
                                        fontSize: 14,
                                        color: AppTheme().greyScale2,
                                      ),
                                ),
                                Container(
                                  height: 100.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: ThemeButton(
                      width: 1.sw,
                      height: 50.h,
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      color: AppTheme().primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        viewModel.showTrade(context, widget.marketItem);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buy',
                            style: AppTheme().paragraphSemiBoldText.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildImageBox() {
    return Container(
      height: 350.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Hero(
              tag: widget.heroTag != null
                  ? widget.heroTag!
                  : '${widget.marketItem.name}',
              transitionOnUserGestures: false,
              child: ImageFiltered(
                imageFilter: new ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 250.h,
                    autoPlay: false,
                    initialPage: 0,
                    scrollPhysics: AlwaysScrollableScrollPhysics(),
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                    onScrolled: (value) {
                      dotPosition.value = value;
                    },
                  ),
                  carouselController: carouselController,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Image.asset(
                    widget.marketItem.imageUrl!.appImage,
                    width: 1.sw,
                    height: 300.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: IgnorePointer(
              ignoring: true,
              child: ImageFiltered(
                imageFilter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: 1.sw,
                  height: 450.h,
                  color: Colors.black.withOpacity(0.10),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<double?>(
              valueListenable: dotPosition,
              builder: (context, dotpos, child) {
                return DotsIndicator(
                  dotsCount: 1,
                  position: dotpos ?? 0,
                  decorator: DotsDecorator(
                    color: AppTheme().greyScale5,
                    activeColor: AppTheme().primaryColor,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
