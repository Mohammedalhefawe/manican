import 'package:flutter/material.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/clients/domain/entities/client.dart';
import 'package:manicann/features/employees/domain/entities/employee.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class DeleteDialog<T> extends StatelessWidget {
  final T object;
  final void Function() deleteFunction;
  DeleteDialog({
    required this.object,
    required this.deleteFunction,
    super.key,
  });
  String role = "";

  @override
  Widget build(BuildContext context) {
    if (T is Employee) {
      role = "الموظف";
    } else {
      role = "الزبون";
    }
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: veryLightGrey,
      child: buildDialogContent(context),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 22.w,
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'هل أنت متأكد من حذف $role : ',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Cairo"),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              _getMessage(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Cairo",
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: myButton(
                    hasBorder: false,
                    backgroundColor: errorColor,
                    text: "تأكيد",
                    textColor: Colors.white,
                    onPressed: deleteFunction,
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: myButton(
                      backgroundColor: veryLightGrey,
                      text: "تراجع",
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getMessage() {
    if (object is Employee) {
      Employee e = object as Employee;
      return '${e.firstName ?? ""} ${e.lastName ?? ""}';
    } else {
      Client c = object as Client;
      return '${c.firstName ?? ""} ${c.lastName ?? ""}';
    }
    return "";
  }
}

class CustomDialog extends StatelessWidget {
  final void Function() function;
  final String text;
  final Color? color;
  const CustomDialog({
    required this.function,
    super.key,
    required this.text,
    this.color = mainYellowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: veryLightGrey,
      child: buildDialogContent(context),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 22.w,
        height: 170,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Cairo",
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: myButton(
                    hasBorder: false,
                    backgroundColor: color!,
                    text: "تأكيد",
                    textColor: whiteColor,
                    onPressed: function,
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: myButton(
                      backgroundColor: veryLightGrey,
                      text: "تراجع",
                      hasBorder: false,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
