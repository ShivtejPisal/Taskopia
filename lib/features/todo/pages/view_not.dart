import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskoopia/common/utils/constants.dart';
import 'package:taskoopia/common/widgets/appstyle.dart';
import 'package:taskoopia/common/widgets/height_spacer.dart';
import 'package:taskoopia/common/widgets/reusable_text.dart';
import 'package:taskoopia/common/widgets/width_spacer.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key, this.payload}) : super(key: key);

  final String? payload;

  @override
  Widget build(BuildContext context) {
    if (payload == null) {
      return Container();
    }
    var title = payload!.split('|')[0];
    var desc = payload!.split('|')[1];
    var date = payload!.split('|')[2];
    var start = payload!.split('|')[3];
    var finish = payload!.split('|')[4];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Container(
                width: AppConst.kWidth,
                height: AppConst.kHeight * 0.7,
                decoration: BoxDecoration(
                    color: AppConst.kBkLight,
                    borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius))),
                child: Padding(
                  padding: EdgeInsets.all(12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: "Reminder",
                          style: appstyle(40, AppConst.kLight, FontWeight.bold)),

                      HeightSpacer(value: 5),

                      Container(
                        width: AppConst.kWidth,
                        padding: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          color: AppConst.kYellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.h),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: "Today",
                                style: appstyle(14, AppConst.kBkDark, FontWeight.bold)),
                            const WidthSpacer(wydth: 15),
                            ReusableText(
                              text: "From :  $start  To :  $finish",
                              style: appstyle(15, AppConst.kBkDark, FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      HeightSpacer(value: 10),

                      ReusableText(
                          text: title,
                          style: appstyle(30, AppConst.kBkDark, FontWeight.bold)),

                      HeightSpacer(value: 10),

                      Text(
                        desc,
                        maxLines: 8,
                        textAlign: TextAlign.justify,
                        style: appstyle(16, AppConst.kLight, FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: -10,
              child: Image.asset(
                'assets/demo_1.png',
                width: 70.w,
                height: 70.h,
              ), // get a bell image or icon

            ),
            Positioned(
              bottom: -AppConst.kHeight * 0.142,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/demo_2.png',
                width: AppConst.kWidth * 0.8,
                height: AppConst.kHeight * 0.6,
              ), // get a different image

            ),
          ],
        ),
      ),
    );
  }
}
