part of 'settings_page.dart';

class _TopBar extends StatefulWidget {
  const _TopBar({
    Key? key,
  }) : super(key: key);

  @override
  State<_TopBar> createState() => __TopBarState();
}

class __TopBarState extends State<_TopBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(right: 20, left: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 10, bottom: 10, right: 20),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        /*SizedBox(
          height: 15,
        ),*/
        /*InkWell(
          onTap: () {
            //
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppTheme().greyScale5,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.search_sharp,
                  color: AppTheme().greyScale1,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Search',
                  style: AppTheme().extraSmallParagraphRegularText.copyWith(
                        color: AppTheme().greyScale2,
                      ),
                ),
              ],
            ),
          ),
        ),*/
      ],
    );
  }
}
