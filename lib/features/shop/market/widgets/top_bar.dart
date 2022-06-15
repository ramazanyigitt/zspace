import 'package:flutter/material.dart';

import '../../../../shared/app_theme.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20, left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 24,
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
