import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:manicann/core/constance/appImgaeAsset.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/app_theme.dart';
import 'package:manicann/features/profile/presentation/widgets/statistics.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  final double rate;
  final int numOfServeces;
  final String? image;
  final List dataLabel;
  final List dataValue;
  final List<double> sectionsVal;
  final List<String> sectionsName;
  final List<Color> colors;

  const ProfileScreen(
      {super.key,
      required this.rate,
      required this.numOfServeces,
      this.image,
      required this.dataLabel,
      required this.dataValue,
      required this.sectionsVal,
      required this.sectionsName,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Container(
          height: 100.h,
          width: 20.w,
          color: Colors.grey,
        ),
        Container(
          height: 100.h,
          width: 80.w,
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 30.h,
                        width: 80.w,
                        child: Image.asset(
                          AppImageAsset.backgroundProfile,
                          fit: BoxFit.cover,
                          height: 100.h,
                          width: 80.w,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Rate :",
                                  style: appTheme.textTheme.titleLarge,
                                ),
                                RatingBar.builder(
                                  itemSize: 15,
                                  initialRating: rate,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: AppColors.primary,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text("Num of Services : $numOfServeces",
                                style: appTheme.textTheme.titleLarge),
                          ],
                        ),
                      )
                    ],
                  ),
                  PositionedDirectional(
                    bottom: -12.h,
                    start: 2.w,
                    child: Container(
                      height: 15.w,
                      width: 15.w,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      // ignore: sort_child_properties_last
                      child: Image.network(
                        image ??
                            'https://images.hivisasa.com/1200/It9Rrm02rE20.jpg',
                        fit: BoxFit.cover,
                        height: 15.w,
                        width: 15.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: List.generate(3, (index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 10.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 11.h,
                                        width: 0.15.w,
                                        color: AppColors.primary,
                                      ),
                                      CircleAvatar(
                                        radius: 4,
                                        backgroundColor: AppColors.secondary,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    "${dataValue[index]} : ${dataLabel[index]}",
                                    style: appTheme.textTheme.titleLarge!
                                        .copyWith(
                                            height: 0.1,
                                            fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 6.h),
                    height: 50.h,
                    width: 40.w,
                    child: StatisticsWidget(
                      sectionsVal: sectionsVal,
                      sectionsName: sectionsName,
                      colors: colors,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
