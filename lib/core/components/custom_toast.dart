import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_colors.dart';

class CustomToast {
  final String type;
  final String msg;
  final double? toastBorder;
  final double? toastWidth;
  final double? toastHeight;
  final double? bottomPadding;
  final Color? secondaryColor;

  const CustomToast({
    required this.type,
    required this.msg,
    this.toastBorder,
    this.toastWidth,
    this.toastHeight,
    this.bottomPadding,
    this.secondaryColor,
  });
  void call(BuildContext context) {
    Color brightColor;
    Color mainColor;
    IconData icon;
    String firstLine;
    if (type == "Success") {
      brightColor = brightGreenColor;
      mainColor = successColor;
      icon = Icons.check;
      firstLine = "تمت العملية بنجاح";
    } else if (type == "Warning") {
      brightColor = brightMainYellowColor;
      mainColor = mainYellowColor;
      icon = Icons.error;
      firstLine = "إجراء مطلوب";
    } else {
      brightColor = brightRedColor;
      mainColor = errorColor;
      icon = Icons.clear;
      firstLine = "حدثت مشكلة";
    }
    final snackBar = SnackBar(
      content: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(toastBorder ?? 10),
            child: Container(
              width: toastWidth ?? 360,
              height: toastHeight ?? 80,
              color: brightColor,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPadding ?? 4),
                child: Container(
                  color: veryLightGrey,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: mainColor.withOpacity(0.2),
                                borderRadius:
                                    const BorderRadiusDirectional.only(
                                  topEnd: Radius.elliptical(11, 37.5),
                                  bottomEnd: Radius.elliptical(11, 37.5),
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: secondaryColor ?? mainBlueColor,
                              child: CircleAvatar(
                                radius: 11,
                                backgroundColor: mainColor,
                                child: type != "Warning"
                                    ? Icon(
                                        icon,
                                        color: secondaryColor ?? mainBlueColor,
                                        size: 17,
                                        weight: 20,
                                      )
                                    : Text(
                                        "!",
                                        style: TextStyle(
                                          color:
                                              secondaryColor ?? mainBlueColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      firstLine,
                                      style: TextStyle(
                                        fontFamily: "Cairo",
                                        color: mainColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      msg,
                                      style: TextStyle(
                                        fontFamily: "Cairo",
                                        color: secondaryColor ?? mainBlueColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
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
            ),
          ),
          const Spacer()
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      //margin: const EdgeInsets.only(left: 16, bottom: 16),
      //width: 400,
    );
    if (ScaffoldMessenger.maybeOf(context) != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      // Handle the case where Scaffold is not available
      print('Scaffold is not available in the widget tree');
    }
  }
}
