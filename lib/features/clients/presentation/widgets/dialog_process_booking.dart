import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/clients/presentation/bloc/cubit.dart';
import 'package:manicann/features/clients/presentation/bloc/states.dart';
import 'package:sizer/sizer.dart';

class ProcessBookingDialog extends StatelessWidget {
  final int bookingId;
  const ProcessBookingDialog({
    super.key,
    required this.bookingId,
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
    return BlocConsumer<ClientsCubit, ClientsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ClientsCubit.get(context);
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
                  const Text(
                    'هل تريد تثبيت الحجز أم إلغاؤه',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Cairo"),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: myButton(
                          backgroundColor: successColor,
                          text: "تثبيت",
                          onPressed: () {
                            cubit.submitBooking(bookingId);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        child: myButton(
                            backgroundColor: errorColor,
                            text: "إلغاء",
                            onPressed: () {
                              cubit.declineBooking(bookingId);
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
