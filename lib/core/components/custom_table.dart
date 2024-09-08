import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:manicann/core/components/details_Dialog.dart';
import 'package:manicann/shared_screen/no_data_screen.dart';
import 'package:manicann/core/components/table_page_selector.dart';
import 'package:manicann/features/clients/domain/entities/booking.dart';
import 'package:manicann/features/clients/domain/entities/client.dart';
import 'package:manicann/features/complaints/domain/entities/complaint.dart';
import 'package:manicann/features/employees/domain/entities/attendance.dart';
import 'package:manicann/features/employees/domain/entities/employee.dart';
import '../theme/app_colors.dart';
import '../theme/font_styles.dart';
import 'buttons.dart';

class CustomTable<T> extends StatelessWidget {
  final String type;
  final List<T> list;
  final int pageIndex;
  final int numColumns;
  final List<int> flexes; // should have $numColumns elements
  final List<String> labels; // should have $numColumns elements
  final List<double> sizedBoxesWidth; // should have ($numColumns - 1) elements
  final void Function(int newPage)? changeTablePage;
  final List<void Function(T object)> tableFunctions;
  final void Function()? deleteDialog;
  final Color? firstColor;
  final Color? secondColor;
  final double? borderRadius;
  final double? elevation;
  final double? width;
  final double? height;

  const CustomTable({
    super.key,
    required this.list,
    required this.type,
    required this.pageIndex,
    required this.numColumns,
    required this.flexes,
    required this.labels,
    required this.sizedBoxesWidth,
    required this.changeTablePage,
    required this.tableFunctions,
    this.deleteDialog,
    this.firstColor,
    this.secondColor,
    this.borderRadius,
    this.elevation,
    this.width,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    int dataRows = 0;
    return ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) {
        return Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Card(
              color: lightGrey,
              surfaceTintColor: Colors.transparent,
              elevation: elevation ?? 12.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // Increased the itemCount by 1 to accommodate the header row
                      itemCount: dataRows =
                          (min(6, list.length - (6 * (pageIndex - 1))) + 1),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Header row
                          return Container(
                            decoration: BoxDecoration(
                              color: firstColor ??
                                  Colors
                                      .white, // Different color for the header row
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 8.0),
                              child: SizedBox(
                                height: 31,
                                child: Row(
                                  children: _tableHeaderRowBuilder(
                                    type: type,
                                    numColumns: numColumns,
                                    labels: labels,
                                    flexes: flexes,
                                    sizedBoxesWidth: sizedBoxesWidth,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Data rows
                          return Container(
                            decoration: BoxDecoration(
                              color: index.isEven
                                  ? firstColor ?? Colors.white
                                  : secondColor ?? lightGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 4.0),
                              child: SizedBox(
                                height: 31,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: _rowBuilder(
                                    context: context,
                                    rowIndex: index,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const Spacer(),
                  TablePagesSelectorBuilder(
                    totalPages: ((list.length - 1) / 6).floor() + 1,
                    changePageFunction: changeTablePage,
                    selectedPageIndex: pageIndex,
                  )
                ],
              ),
            ),
          ),
        );
      },
      fallback: (context) {
        return const EmptyScreen();
      },
    );
  }

  List<Widget> _tableHeaderRowBuilder({
    required String type,
    required int numColumns,
    required List<int> flexes, // should have $numColumns elements
    required List<String> labels, // should have $numColumns elements
    required List<double>
        sizedBoxesWidth, // should have ($numColumns - 1) elements
  }) {
    List<Widget> headerRow = [];
    for (int i = 0; i < numColumns; i++) {
      headerRow.add(Expanded(
          flex: flexes[i],
          child: Text(
            labels[i],
            style: headerTableTextStyle,
            textAlign: i != numColumns - 1 ? TextAlign.start : TextAlign.end,
          )));
      if (i != numColumns - 1) {
        headerRow.add(SizedBox(
          width: sizedBoxesWidth[i],
        ));
      }
    }
    return headerRow;
  }

  List<Widget> _rowBuilder({
    required BuildContext context,
    required int rowIndex,
  }) {
    List<Widget> row = [];
    for (int i = 0; i < numColumns; i++) {
      row.add(Expanded(
        flex: flexes[i],
        child: _cellBuilder(
          context: context,
          rowIndex: rowIndex,
          index: i + 1,
          object: list[6 * (pageIndex - 1) + rowIndex - 1],
        ),
      ));
      if (i != numColumns - 1) {
        row.add(SizedBox(
          width: sizedBoxesWidth[i],
        ));
      }
    }
    return row;
  }

  Widget _cellBuilder({
    required BuildContext context,
    required int rowIndex,
    required index,
    required T object,
  }) {
    if (type == "Employees") {
      final employee = list[6 * (pageIndex - 1) + rowIndex - 1] as Employee;
      switch (index) {
        case 1:
          return Text(
            "${employee.firstName} ${employee.lastName}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 2:
          return Text(
            employee.position ?? "specialist",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 3:
          return Text(
            employee.phoneNumber ?? "",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 4:
          return Row(
            key: ValueKey<Employee>(employee),
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5,
              ),
              MyIconButton(
                  icon: Icons.edit,
                  mainColor: blackColor,
                  hoverColor: brightMainYellowColor,
                  iconSize: 20,
                  onPressed: () {
                    tableFunctions[0](employee as T);
                  }),
            ],
          );
        case 5:
          return Row(
            key: ValueKey<Employee>(employee),
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5,
              ),
              MyIconButton(
                icon: Icons.delete,
                mainColor: blackColor,
                hoverColor: errorColor,
                iconSize: 20,
                onPressed: () => tableFunctions[1](employee as T),
              ),
            ],
          );
        default:
          return Row(
            key: ValueKey<Employee>(employee),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyTextButton(
                text: const Text(
                  'عرض',
                  style: TextStyle(
                    color: mainYellowColor,
                    fontFamily: "Cairo",
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: mainYellowColor,
                  ),
                ),
                mainColor: mainYellowColor,
                hoverColor: brightMainYellowColor,
                onPressed: () => tableFunctions[2](employee as T),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          );
      }
    } else if (type == "Complaints") {
      Complaint complaint =
          list[6 * (pageIndex - 1) + rowIndex - 1] as Complaint;
      switch (index) {
        case 1:
          return Text(
            "${complaint.customerFirstName} ${complaint.customerLastName}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 2:
          return Text(
            complaint.date != null
                ? "${complaint.date?.year}/${complaint.date?.month}/${complaint.date?.day}"
                : "2022/08/14",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 3:
          return Text(
            complaint.day ?? "",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 4:
          return Row(
            key: ValueKey<Complaint>(complaint),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: MyTextButton(
                    text: Text(
                      complaint.content ?? "",
                      style: defaultFontStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    mainColor: blackColor,
                    hoverColor: Colors.black,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DetailsDialog(
                            text: complaint.content ?? "",
                            width: width != null ? width! / 4 : 300,
                            height: height != null ? height! / 3 : 300,
                          );
                        },
                      );
                    }),
              ),
            ],
          );
        default:
          return Row(
            key: ValueKey<Complaint>(complaint),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyIconButton(
                icon: Icons.delete,
                mainColor: blackColor,
                hoverColor: errorColor,
                iconSize: 20,
                onPressed: () => tableFunctions[0](complaint as T),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          );
      }
    } else if (type == "Attendance") {
      Attendance attendance =
          list[6 * (pageIndex - 1) + rowIndex - 1] as Attendance;
      switch (index) {
        case 1:
          return Text(
            "${attendance.day}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 2:
          return Text(
            attendance.date != null
                ? "${attendance.date?.year}/${attendance.date?.month}/${attendance.date?.day}"
                : "2022/08/14",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 3:
          return Text(
            "9:00 am",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 4:
          return Text(
            "4:00 pm",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        default:
          if (attendance.isAbsence == null || attendance.isAbsence == false) {
            return const Text(
              "غياب",
              style: TextStyle(
                  color: errorColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Cairo"),
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          }
          return const Text(
            "حضور",
            style: TextStyle(
                color: successColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                fontFamily: "Cairo"),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
      }
    } else if (type == "Clients") {
      Client client = list[6 * (pageIndex - 1) + rowIndex - 1] as Client;
      switch (index) {
        case 1:
          return Text(
            "${client.firstName} ${client.lastName}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 2:
          return Text(
            "${client.phoneNumber}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 3:
          return Row(
            key: ValueKey<Client>(client),
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 6,
              ),
              MyTextButton(
                text: const Text(
                  'إضافة',
                  style: TextStyle(
                    color: mainYellowColor,
                    fontFamily: "Cairo",
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: mainYellowColor,
                  ),
                ),
                mainColor: mainYellowColor,
                hoverColor: brightMainYellowColor,
                onPressed: () => tableFunctions[0](client as T),
              ),
            ],
          );
        case 4:
          return Row(
            key: ValueKey<Client>(client),
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5,
              ),
              MyIconButton(
                  icon: Icons.edit,
                  mainColor: blackColor,
                  hoverColor: brightMainYellowColor,
                  iconSize: 20,
                  onPressed: () {
                    tableFunctions[1](client as T);
                  }),
            ],
          );
        case 5:
          return Row(
            key: ValueKey<Client>(client),
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5,
              ),
              MyIconButton(
                icon: Icons.delete,
                mainColor: blackColor,
                hoverColor: errorColor,
                iconSize: 20,
                onPressed: () => tableFunctions[2](client as T),
              ),
            ],
          );
        default:
          return Row(
            key: ValueKey<Client>(client),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyTextButton(
                text: const Text(
                  'عرض',
                  style: TextStyle(
                    color: mainYellowColor,
                    fontFamily: "Cairo",
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: mainYellowColor,
                  ),
                ),
                mainColor: mainYellowColor,
                hoverColor: brightMainYellowColor,
                onPressed: () => tableFunctions[3](client as T),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          );
      }
    } else if (type == "CurrentBookings") {
      Booking currentBooking =
          list[6 * (pageIndex - 1) + rowIndex - 1] as Booking;
      switch (index) {
        case 1:
          return Text(
            "${currentBooking.employeeFirstName} ${currentBooking.employeeLastName}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          );
        case 2:
          return Text(
            currentBooking.serviceName ?? "",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 3:
          Color color;
          String text;
          if (currentBooking.status != null &&
              currentBooking.status?.toLowerCase() == "done") {
            color = successColor;
            text = "مثبت";
          } else if (currentBooking.status != null &&
              currentBooking.status?.toLowerCase() == "waiting") {
            color = mainBlueColor;
            text = "قيد الانتظار";
          } else {
            color = errorColor;
            text = "ملغي";
          }
          return Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamily: "Cairo",
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 4:
          return Text(
            "${currentBooking.day}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 5:
          return Text(
            currentBooking.date ?? "--/--/--",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 6:
          return Text(
            currentBooking.time ?? "",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        default:
          return Row(
            key: ValueKey<Booking>(currentBooking),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyTextButton(
                text: const Text(
                  'معالجة',
                  style: TextStyle(
                    color: mainYellowColor,
                    fontFamily: "Cairo",
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: mainYellowColor,
                  ),
                ),
                mainColor: mainYellowColor,
                hoverColor: brightMainYellowColor,
                onPressed: () => tableFunctions[0](currentBooking as T),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          );
      }
    } else if (type == "ArchivedBookings") {
      Booking currentBooking =
          list[6 * (pageIndex - 1) + rowIndex - 1] as Booking;
      switch (index) {
        case 1:
          return Text(
            "${currentBooking.employeeFirstName} ${currentBooking.employeeLastName}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          );
        case 2:
          return Text(
            currentBooking.serviceName ?? "",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 3:
          Color color;
          String text;
          if (currentBooking.status != null &&
              currentBooking.status?.toLowerCase() == "done") {
            color = successColor;
            text = "منتهي";
          } else {
            color = errorColor;
            text = "ملغي";
          }
          return Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamily: "Cairo",
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 4:
          return Text(
            "${currentBooking.day}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 5:
          return Text(
            currentBooking.date ?? "--/--/--",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 6:
          return Text(
            currentBooking.time ?? "",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        default:
          String text;
          if (currentBooking.status != null &&
              currentBooking.status?.toLowerCase() != "declined") {
            text = currentBooking.endTime ?? "--------";
          } else {
            text = "--------";
          }
          return Row(
            key: ValueKey<Booking>(currentBooking),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                text,
                style: defaultFontStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 10,
              )
            ],
          );
      }
    } else if (type == "AllCurrentBookings") {
      Booking currentBooking =
          list[6 * (pageIndex - 1) + rowIndex - 1] as Booking;
      switch (index) {
        case 1:
          return Text(
            "${currentBooking.customerFirstName} ${currentBooking.customerLastName}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          );
        case 2:
          return Text(
            "${currentBooking.employeeFirstName} ${currentBooking.employeeLastName}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          );
        case 3:
          return Text(
            currentBooking.serviceName ?? "",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 4:
          Color color;
          String text;
          if (currentBooking.status != null &&
              currentBooking.status?.toLowerCase() == "done") {
            color = successColor;
            text = "مثبت";
          } else if (currentBooking.status != null &&
              currentBooking.status?.toLowerCase() == "waiting") {
            color = mainBlueColor;
            text = "قيد الانتظار";
          } else {
            color = errorColor;
            text = "ملغي";
          }
          return Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamily: "Cairo",
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 5:
          return Text(
            "${currentBooking.day}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 6:
          return Text(
            currentBooking.date ?? "--/--/--",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 7:
          return Text(
            currentBooking.time ?? "",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        default:
          return Row(
            key: ValueKey<Booking>(currentBooking),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyTextButton(
                text: const Text(
                  'معالجة',
                  style: TextStyle(
                    color: mainYellowColor,
                    fontFamily: "Cairo",
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: mainYellowColor,
                  ),
                ),
                mainColor: mainYellowColor,
                hoverColor: brightMainYellowColor,
                onPressed: () => tableFunctions[0](currentBooking as T),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          );
      }
    } else if (type == "AllArchivedBookings") {
      Booking currentBooking =
          list[6 * (pageIndex - 1) + rowIndex - 1] as Booking;
      switch (index) {
        case 1:
          return Text(
            "${currentBooking.customerFirstName} ${currentBooking.customerLastName}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          );
        case 2:
          return Text(
            "${currentBooking.employeeFirstName} ${currentBooking.employeeLastName}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          );
        case 3:
          return Text(
            currentBooking.serviceName ?? "",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 4:
          Color color;
          String text;
          if (currentBooking.status != null &&
              currentBooking.status?.toLowerCase() == "done") {
            color = successColor;
            text = "منتهي";
          } else {
            color = errorColor;
            text = "ملغي";
          }
          return Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamily: "Cairo",
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 5:
          return Text(
            "${currentBooking.day}",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 6:
          return Text(
            currentBooking.date ?? "--/--/--",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case 7:
          return Text(
            currentBooking.time ?? "",
            style: defaultFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        default:
          String text;
          if (currentBooking.status != null &&
              currentBooking.status?.toLowerCase() != "declined") {
            text = currentBooking.endTime ?? "--------";
          } else {
            text = "--------";
          }
          return Row(
            key: ValueKey<Booking>(currentBooking),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                text,
                style: defaultFontStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 10,
              )
            ],
          );
      }
    }

    return Container();
  }
}
