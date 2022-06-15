part of 'market_item_detail_page.dart';

class _TopBar extends StatelessWidget {
  final MarketItemModel marketItem;
  const _TopBar({
    Key? key,
    required this.marketItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      marketItem.name ?? '',
                      style: AppTheme().paragraphSemiBoldText.copyWith(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Container(
                      height: 5.h,
                    ),
                    Text(
                      '${marketItem.buyPrice?.toString()} Credit',
                      style: AppTheme().smallParagraphSemiBoldText.copyWith(
                            color: AppTheme().primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Level',
                      style: AppTheme().smallParagraphSemiBoldText.copyWith(),
                    ),
                    Text(
                      '${marketItem.level?.episodeId}',
                      style: AppTheme().smallParagraphRegularText.copyWith(
                            color: AppTheme().greyScale2,
                            fontSize: AppTheme()
                                    .smallParagraphSemiBoldText
                                    .fontSize! *
                                0.8,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: 2.h,
        ),
      ],
    );
  }
}
