import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zspace/features/_components/local_image_box.dart';

import '../../../../../shared/app_theme.dart';
import '../../../../core/utils/router/app_navigator.dart';
import '../../../../data/models/market_item_model.dart';
import '../../../../shared/app_images.dart';
import '../../market_item_detail/market_item_detail_page.dart';

class MarketItemsList extends StatelessWidget {
  final List<MarketItemModel> marketItems;
  const MarketItemsList({
    Key? key,
    required this.marketItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*Container(
      margin: EdgeInsets.only(left: 15.w),
      child: Container(
        margin: EdgeInsets.only(right: 15.w),
        child: */
        marketItems.length == 0
            ? SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'No items available',
                    style: AppTheme().paragraphSemiBoldText.copyWith(
                          color: AppTheme().greyScale0,
                        ),
                  ),
                ),
              )
            : SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return buildItem(context, index);
                  },
                  childCount: marketItems.length,
                ),
                /*),
      ),*/
              );
  }

  Widget buildItem(BuildContext context, int index) {
    final marketItem = marketItems[index];
    return Material(
      elevation: 0.25,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          AppNavigator.push(
            context: context,
            child: MarketItemDetailPage(marketItem: marketItem),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppTheme().greyScale5,
          ),
          width: 160.w,
          height: 200.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              (marketItem.imageUrl != null)
                  ? Hero(
                      tag: marketItem.name!,
                      child: Container(
                        width: 64.w,
                        height: 64.w,
                        child: Center(
                          child: Image.asset(marketItem.imageUrl!.appImage),
                        ),
                      ),
                    )
                  : LocalImageBox(
                      width: 64,
                      height: 64,
                      imgUrl: 'planet.png',
                    ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      marketItem.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTheme().smallParagraphSemiBoldText.copyWith(
                            color: AppTheme().blackColor,
                            fontSize: 16,
                          ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      '${marketItem.buyPrice.toString()} Credit',
                      style: AppTheme().extraSmallParagraphRegularText.copyWith(
                            fontSize: 13,
                            color: AppTheme().greyScale0,
                          ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      child: Text(
                        marketItem.description!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:
                            AppTheme().extraSmallParagraphRegularText.copyWith(
                                  fontSize: 13,
                                  color: AppTheme().greyScale2,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
