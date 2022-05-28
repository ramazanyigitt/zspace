import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StagePlanet extends StatelessWidget {
  StagePlanet();

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.fromLTRB(viewPortMargin, 0.w, 0.w, 0.w),
      width: 0.7.sw,
      height: 200.w,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200.w,
              child: Image.asset(
                "assets/images/planet.png",
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Bölüm uzunluğu: 50",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "Eski insan türüne ait gezegen",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
