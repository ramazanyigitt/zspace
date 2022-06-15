import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/features/_components/curved_container.dart';
import 'package:zspace/features/shop/market/widgets/market_category_list.dart';
import 'package:zspace/features/shop/market/widgets/market_items_list.dart';
import '../../../core/utils/lottie/lottie_cache.dart';
import '../../../injection_container.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'market_viewmodel.dart';
import 'widgets/top_bar.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<MarketViewModel>.reactive(
      viewModelBuilder: () => MarketViewModel(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Stack(
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
              Positioned.fill(
                child: Container(
                  child: SafeArea(
                    child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        // These are the slivers that show up in the "outer" scroll view.
                        return <Widget>[
                          SliverOverlapAbsorber(
                            // This widget takes the overlapping behavior of the SliverAppBar,
                            // and redirects it to the SliverOverlapInjector below. If it is
                            // missing, then it is possible for the nested "inner" scroll view
                            // below to end up under the SliverAppBar even when the inner
                            // scroll view thinks it has not been scrolled.
                            // This is not necessary if the "headerSliverBuilder" only builds
                            // widgets that do not overlap the next sliver.
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                            sliver: SliverAppBar(
                              automaticallyImplyLeading: false,
                              backgroundColor: Colors.transparent,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    TopBar(),
                                  ],
                                ),
                              ),
                              expandedHeight: 50,
                            ),
                          ),
                        ];
                      },
                      body: CurvedContainer(
                        radius: 30,
                        child: Container(
                          color: AppTheme().whiteColor,
                          child: (!viewModel.isInited)
                              ? Container(
                                  height: 0.75.sh,
                                  child: Center(
                                    child: Container(
                                      width: 48.w,
                                      height: 48.w,
                                      child: CircularProgressIndicator.adaptive(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          AppTheme().darkPrimaryColor,
                                        ),
                                        strokeWidth: 3,
                                      ),
                                    ),
                                  ),
                                )
                              : CustomScrollView(
                                  //mainAxisSize: MainAxisSize.min,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  slivers: [
                                    SliverPersistentHeader(
                                      pinned: true,
                                      floating: true,
                                      delegate: PersistentHeader(
                                        widget: Container(
                                          color: AppTheme().bgColor,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 25.h,
                                              ),
                                              MarketCategoryList(
                                                selectedCategory:
                                                    viewModel.selectedCategory,
                                                onCategorySelected: (category) {
                                                  viewModel
                                                      .changeCategory(category);
                                                },
                                              ),
                                              SizedBox(
                                                height: 12.5.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    viewModel.isLoading
                                        ? SliverPadding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12.5.h,
                                                horizontal: 15.w),
                                            sliver: SliverToBoxAdapter(
                                              child: Container(
                                                child: Center(
                                                  child: Container(
                                                    width: 48.w,
                                                    height: 48.w,
                                                    child:
                                                        CircularProgressIndicator
                                                            .adaptive(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        AppTheme()
                                                            .darkPrimaryColor,
                                                      ),
                                                      strokeWidth: 3,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SliverPadding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12.5.h,
                                                horizontal: 15.w),
                                            sliver: MarketItemsList(
                                              marketItems:
                                                  viewModel.marketItems,
                                            ),
                                          ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  double get maxExtent =>
      ((AppTheme().largeParagraphBoldText.fontSize?.h) ?? 0) +
      10.h +
      35.h +
      25.h +
      12.5.h;

  @override
  double get minExtent =>
      ((AppTheme().largeParagraphBoldText.fontSize?.h) ?? 0) +
      10.h +
      35.h +
      25.h +
      12.5.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
