import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zspace/injection_container.dart';
import '../../../../data/enums/win_point_category.dart';

import '../../../../domain/repositories/local_data_repository.dart';
import '../../../../shared/app_theme.dart';

class MarketCategoryList extends StatelessWidget {
  final Function(MarketCategory) onCategorySelected;
  final MarketCategory selectedCategory;
  const MarketCategoryList({
    Key? key,
    required this.onCategorySelected,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15.w),
                height: ((AppTheme().largeParagraphBoldText.fontSize)?.h ?? 0),
                child: Text(
                  'Market',
                  style: AppTheme().largeParagraphBoldText.copyWith(
                        color: AppTheme().greyScale0,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 15.w),
                child: Text(
                  'Your credit: ${locator<LocalDataRepository>().getUser().credit}',
                  style: AppTheme().smallParagraphSemiBoldText.copyWith(
                        color: AppTheme().greyScale0,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 35.h,
            child: ListView.builder(
              itemCount: MarketCategory.values.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final bool isFirst = index == selectedCategory.index;
                return Container(
                  margin:
                      EdgeInsets.only(left: index == 0 ? 15.w : 0, right: 8.w),
                  child: GestureDetector(
                    onTap: () {
                      onCategorySelected(MarketCategory.values[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: isFirst
                              ? AppTheme().darkPrimaryColor
                              : Colors.transparent,
                          border: Border.all(
                            color: isFirst
                                ? AppTheme().darkPrimaryColor
                                : AppTheme().greyScale4,
                          )),
                      height: 35.h,
                      child: Center(
                        child: Text(
                          MarketCategory.values[index].getCategoryName,
                          style:
                              AppTheme().extraSmallParagraphMediumText.copyWith(
                                    color: isFirst
                                        ? AppTheme().greyScale6
                                        : AppTheme().greyScale2,
                                  ),
                        ),
                      ),
                    ),
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
