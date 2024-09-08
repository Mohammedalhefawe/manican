import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/delete_dialog.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/booking/presentation/pages/booking_screen.dart';
import 'package:manicann/features/clients/presentation/pages/profile_screen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/custom_table.dart';
import '../../../../core/components/dashboard_builder.dart';
import '../../../../core/components/page_label.dart';
import '../../../../core/components/search_text_form_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/client.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../widgets/dialog_add_client.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = max(MediaQuery.of(context).size.width, 1000);
    double screenHeight = max(MediaQuery.of(context).size.height, 650);
    double sideBarWidth = 210;
    return BlocConsumer<ClientsCubit, ClientsStates>(
      listener: (context, state) {
        if (state is GetClientsErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
        if (state is DeleteClientErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
        if (state is DeleteClientSuccessState) {
          CustomToast t =
              const CustomToast(type: "Success", msg: "تم حذف العميل بنجاح");
          t(context);
        }
        if (state is AddClientErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
        if (state is AddClientSuccessState) {
          CustomToast t =
              const CustomToast(type: "Success", msg: "تم إضافة العميل بنجاح");
          t(context);
        }
        if (state is EditClientErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
        if (state is EditClientSuccessState) {
          CustomToast t = const CustomToast(
              type: "Success", msg: "تم تعديل بيانات العميل بنجاح");
          t(context);
        }
        if (state is ClientToEditSelectionState) {
          showDialog(
              context: context,
              builder: (context) => const AddClientDialog(isEdit: true));
        }
      },
      builder: (context, state) {
        var cubit = ClientsCubit.get(context);

        Widget pageContent = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60),
          child: ConditionalBuilder(
            condition: state is! GetClientsLoadingState,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pageLabelBuilder(label: "العملاء"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    searchFieldBuilder(
                      hintText: "ابحث هنا...",
                      onChanged: (String value) {
                        cubit.searchInList(value);
                      },
                      contentPadding: 14,
                    ),
                    const Spacer(),
                    myButton(
                      backgroundColor: mainYellowColor,
                      text: "إضافة عميل",
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const AddClientDialog(
                          isEdit: false,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTable<Client>(
                  list: cubit.clientsList,
                  type: "Clients",
                  pageIndex: cubit.clientsTablePageIndex,
                  changeTablePage: (int newPage) =>
                      cubit.changeClientTablePage(newPage),
                  numColumns: 6,
                  labels: const [
                    'الاسم',
                    'رقم الهاتف',
                    'الحجوزات',
                    'تعديل',
                    'حذف',
                    'التفاصيل',
                  ],
                  flexes: const [5, 4, 3, 3, 3, 2],
                  sizedBoxesWidth: const [35, 20, 10, 10, 10],
                  tableFunctions: [
                    (Client client) {
                      if (client.id != null) {
                        var cubit = AppCubit.get(context);
                        int indx = AppLink.role == 'admin' ? 4 : 3;
                        cubit.screens[indx] = AddBookingScreen(
                          idCustomer: client.id!,
                        );
                        cubit.emit(ScreenNavigationState());
                      } else {
                        print('Id customer null Hefawe................');
                        CustomToast t = const CustomToast(
                            type: "Error",
                            msg: "حدث خطأ غير متوقع أعد المحاولة");
                        t(context);
                      }
                    },
                    (Client client) => cubit.selectClientToEdit(client: client),
                    (Client client) => showDialog(
                          context: context,
                          builder: (context) {
                            return BlocConsumer<ClientsCubit, ClientsStates>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return DeleteDialog<Client>(
                                      object: client,
                                      deleteFunction: () {
                                        cubit.deleteClient(
                                            clientId: client.id!);
                                        Navigator.pop(context);
                                      });
                                });
                          },
                        ),
                    (Client client) {
                      double absence = Random().nextDouble() * 100;
                      double attendence = 100 - absence;
                      cubit.selectClientToShowDetails(client: client);
                      cubit.getBookingPercentage(client.id!);

                      var appCubit = AppCubit.get(context);
                      int indx = AppLink.role == 'admin' ? 4 : 3;
                      appCubit.screens[indx] = ClientProfileScreen(
                        dataLabel: const [
                          [
                            'الاسم: ',
                            'رقم الهاتف: ',
                          ]
                        ],
                        dataValue: [
                          [
                            "${client.firstName} ${client.middleName} ${client.lastName}",
                            "${client.phoneNumber}",
                          ]
                        ],
                        // sectionsVal: [
                        //   cubit.bookingPercentage!.customerPercentage!
                        //       .floorToDouble(),
                        //   cubit.bookingPercentage!.othersPercentage!
                        //       .ceilToDouble(),
                        // ],
                        sectionsVal: [attendence, absence],

                        sectionsName: const [
                          'حجوزات العميل',
                          "حجوزات باقي العملاء"
                        ],
                        colors: const [mainYellowColor, mainBlueColor],
                      );
                      appCubit.emit(ScreenNavigationState());
                    },
                  ],
                ),
              ],
            ),
            fallback: (context) => const Center(child: LoadingWidget()),
          ),
        );

        return DashboardPageBuilder(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          sideBarWidth: sideBarWidth,
          pageContent: pageContent,
          isLogin: false,
        );
      },
    );
  }
}
