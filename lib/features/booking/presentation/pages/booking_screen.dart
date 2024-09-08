import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/function/time_formatter.dart';
import 'package:manicann/features/booking/presentation/widgets/custom_dropdown_textfiled.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/font_styles.dart';
import 'package:manicann/features/booking/presentation/bloc/cubit/booking_bolc_cubit.dart';
import 'package:manicann/features/booking/presentation/bloc/cubit/booking_bolc_state.dart';
import 'package:manicann/shared_screen/main_layout_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

class AddBookingScreen extends StatelessWidget {
  final int? idCustomer;
  const AddBookingScreen({
    super.key,
    this.idCustomer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        BookingBloc bloc = BlocProvider.of<BookingBloc>(context);
        Widget pageContent;
        if (state is ErrorBookingState) {
          pageContent = MyErrorWidget(
            text: state.message,
            onTap: () {
              bloc.emit(SuccessBookingState());
            },
          );
        } else if (state is LoadingBookingState) {
          pageContent = const LoadingWidget();
        } else {
          pageContent = Form(
            key: bloc.formstate,
            child: Container(
              height: 100.h,
              width: 80.w,
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "إضافة حجز",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    SizedBox(
                        height: 70.h,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: CustomDropDownButtonAsTextFiled(
                                      hintText: 'اختر الخدمة',
                                      listData: bloc.listServices,
                                      onChanged: (val) {
                                        bloc.changeServiceVlaueDropDown(val);
                                      },
                                      isSelected: bloc.isSelectedService,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  SizedBox(
                                    child: CustomDropDownButtonAsTextFiled(
                                      hintText: 'اختر الموظف',
                                      listData: bloc.listEmployees,
                                      onChanged: (val) {
                                        bloc.changeEmployeeVlaueDropDown(val);
                                      },
                                      isSelected: bloc.isSelectedEmployee,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  DateTableWidget(bloc: bloc)
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: idCustomer == null,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child:
                                              CustomDropDownButtonAsTextFiled(
                                            hintText: 'اختر الزبون',
                                            listData: bloc.listCustomers,
                                            onChanged: (val) {
                                              bloc.changeCustomerVlaueDropDown(
                                                  val);
                                            },
                                            isSelected: bloc.isSelectedCustomer,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'الأوقات المتاحة',
                                    style: textFieldLabelStyle,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        // color: lightGrey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 40.h,
                                      child: bloc.listAvailableTime.isEmpty
                                          ? const Text(
                                              'لا يوجد أوقات متاحة للحجز خلال هذا اليوم , اختر تاريخ آخر من فضلك',
                                              style: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          : GridView.builder(
                                              itemCount:
                                                  bloc.listAvailableTime.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 1.w,
                                                      mainAxisSpacing: 2.h,
                                                      childAspectRatio: 4 / 1),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    bloc.selectAvaliableTime(
                                                        index);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: index ==
                                                              bloc
                                                                  .indexSelectAvaliableTime
                                                          ? mainYellowColor
                                                          : Colors
                                                              .amber.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      "من ${formatArabicTimeEdit("${bloc.listAvailableTime[index].from}:00")} إلى ${formatArabicTimeEdit("${bloc.listAvailableTime[index].to}:00")}",
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )),
                                ],
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      // color: Colors.red,
                      height: 5.h,
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          myButton(
                              width: 7.w,
                              height: 6.h,
                              elevation: 0,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              backgroundColor: whiteColor,
                              onPressed: () {
                                var appCubit = AppCubit.get(context);
                                if (idCustomer != null) {
                                  appCubit.updateSelected(4);
                                } else {
                                  appCubit.updateSelected(3);
                                }
                                // appCubit.emit(ScreenNavigationState());
                              },
                              text: 'إلغاء'),
                          SizedBox(
                            width: 1.5.w,
                          ),
                          myButton(
                              width: 7.w,
                              height: 6.h,
                              elevation: 0,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              backgroundColor: AppColors.primary,
                              onPressed: () {
                                if (idCustomer == null) {
                                  bloc.addBooking(null, context);
                                } else {
                                  bloc.addBooking(idCustomer, context);
                                }
                              },
                              text: 'إضافة'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return MainLayoutScreen(
          pageContent: pageContent,
        );
      },
    ));
  }
}

class DateTableWidget extends StatelessWidget {
  const DateTableWidget({
    super.key,
    required this.bloc,
  });

  final BookingBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر التاريخ',
          style: textFieldLabelStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 35.h,
          width: 40.w,
          decoration: BoxDecoration(
              color: lightGrey, borderRadius: BorderRadius.circular(8)),
          child: dp.DayPicker.single(
            selectedDate: bloc.selectedDate,
            onChanged: (date) {
              bloc.selectedDate = date;
              bloc.emit(SuccessBookingState());
              bloc.getAvaliableTime();
            },
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 1),
            datePickerStyles: dp.DatePickerRangeStyles(
              selectedDateStyle: const TextStyle(color: Colors.white),
              selectedSingleDateDecoration: const BoxDecoration(
                color: mainYellowColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
