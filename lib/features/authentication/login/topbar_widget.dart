part of 'login_page.dart';

class _TopBarWidget extends StatelessWidget {
  const _TopBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.fromLTRB(25.w, 15.h, 20.w, 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Welcome to ZSpace, Stargazer!',
                    style: AppTheme().smallParagraphMediumText.copyWith(
                          fontSize: 26,
                          color: AppTheme().whiteColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
