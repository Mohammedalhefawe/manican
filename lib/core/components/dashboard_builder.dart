import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/delete_dialog.dart';
import 'package:manicann/core/components/navigators.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/di/appInitializer.dart';
import 'package:manicann/features/authentication/presentation/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'dart:html' as html;
import '../constance/appImgaeAsset.dart';
import '../theme/app_colors.dart';

class DashboardPageBuilder extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final double sideBarWidth;
  final Widget pageContent;
  final bool isLogin;
  final Color? sideBarBackgroundColor;
  final Color? mainPartBackgroundColor;
  final Color? selectionColor;
  final double? borderRadius;

  const DashboardPageBuilder({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.sideBarWidth,
    required this.pageContent,
    required this.isLogin,
    this.sideBarBackgroundColor,
    this.mainPartBackgroundColor,
    this.selectionColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    MenuListModel items = MenuListModel();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: screenHeight,
            child: Scaffold(
              body: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: screenWidth,
                            color: sideBarBackgroundColor ?? mainGreyColor,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: screenWidth,
                            color: mainPartBackgroundColor ?? whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      width: max(100.w, 650),
                      child: Row(
                        children: [
                          Container(
                            width: sideBarWidth,
                            height: screenHeight,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.only(
                                  bottomEnd:
                                      Radius.circular(borderRadius ?? 45)),
                              color: sideBarBackgroundColor ?? mainGreyColor,
                            ),
                            child: Padding(
                              padding: isLogin
                                  ? const EdgeInsets.only(top: 0)
                                  : const EdgeInsets.only(top: 35),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (!isLogin)
                                    Center(
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundColor: mainGreyColor,
                                        child: Image.asset(
                                          AppImageAsset.appIcon,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  if (!isLogin)
                                    Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: const BoxDecoration(),
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 20.0, start: 8),
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return menuItemBuilder(
                                              context, index, items, cubit);
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 1,
                                        ),
                                        itemCount: items.items.length,
                                      ),
                                    ),
                                  if (isLogin)
                                    Container(
                                      width: max(350, max(100.w, 650) / 2),
                                      height: screenHeight,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.only(
                                                bottomEnd: Radius.circular(
                                                    borderRadius ?? 45)),
                                        color:
                                            selectionColor ?? mainYellowColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 100, horizontal: 80),
                                        child: Image.asset(
                                          AppImageAsset.login_image,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.only(
                                    topStart:
                                        Radius.circular(borderRadius ?? 45.0)),
                                color: mainPartBackgroundColor ?? whiteColor,
                              ),
                              child: pageContent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MenuItemModel {
  String name;
  IconData iconData;
  MenuItemModel({
    required this.name,
    required this.iconData,
  });
}

class MenuListModel {
  List<MenuItemModel> items = [];

  MenuListModel() {
    items.add(MenuItemModel(
      name: "الصفحة الرئيسية",
      iconData: Icons.home_outlined,
    ));
    if (AppLink.role == 'admin') {
      items.add(MenuItemModel(
        name: "الفروع",
        iconData: Icons.keyboard_return,
      ));
    }
    items.add(MenuItemModel(
      name: "الموظفين",
      iconData: Icons.person_2_outlined,
    ));
    items.add(MenuItemModel(
      name: "الحجوزات",
      iconData: Icons.table_chart_outlined,
    ));
    items.add(MenuItemModel(
      name: "العملاء",
      iconData: Icons.person_outlined,
    ));
    items.add(MenuItemModel(
      name: "الخدمات",
      iconData: Icons.dashboard_outlined,
    ));
    items.add(MenuItemModel(
      name: "العروض",
      iconData: Icons.panorama_fish_eye_rounded,
    ));
    items.add(MenuItemModel(
      name: "قبل وبعد",
      iconData: Icons.post_add_sharp,
    ));
    items.add(MenuItemModel(
      name: "الشكاوي",
      iconData: Icons.support_agent_outlined,
    ));
    items.add(MenuItemModel(
      name: "تسجيل الخروج",
      iconData: Icons.logout_outlined,
    ));
  }
}

Widget menuItemBuilder(
  BuildContext context,
  int index,
  MenuListModel list,
  AppCubit cubit,
) {
  return InkWell(
    onTap: () async {
      if (AppLink.branchId != '0') {
        cubit.updateSelected(index);
      } else {
        const CustomToast(
            type: "Warning",
            msg: 'لا يمكنك التنقل بين الصفحات قبل إضافة فرع')(context);
      }
      if (index == cubit.screensConst.length - 1) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        return showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return CustomDialog(
              color: Colors.red,
              function: () async {
                // Navigator.of(context).pop();
                cubit.selectedScreenIndex = 0;
                await sharedPreferences.clear();
                AppInitializer.isHaveAuth = false;
                navigateTo(context, LoginScreen());
                html.window.location.reload();
              },
              text: 'تأكيد عملية تسجيل الخروج ؟',
            );
          },
        );
      }
    },
    child: Container(
      height: 48,
      decoration: BoxDecoration(
        color: index == cubit.selectedScreenIndex
            ? mainYellowColor
            : Colors.transparent,
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(40.0),
          bottomStart: Radius.circular(40.0),
        ),
      ),
      child: ClipRRect(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                list.items[index].iconData,
                size: 26,
                color: index == cubit.selectedScreenIndex
                    ? blackColor
                    : Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                list.items[index].name,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Cairo",
                  color: index == cubit.selectedScreenIndex
                      ? blackColor
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}








// class DashboardPageBuilder extends StatelessWidget {
//   final double screenWidth;
//   final double screenHeight;
//   final double sideBarWidth;
//   final Widget pageContent;
//   final bool isLogin;
//   final Color? sideBarBackgroundColor;
//   final Color? mainPartBackgroundColor;
//   final Color? selectionColor;
//   final double? borderRadius;

//   const DashboardPageBuilder({
//     super.key,
//     required this.screenWidth,
//     required this.screenHeight,
//     required this.sideBarWidth,
//     required this.pageContent,
//     required this.isLogin,
//     this.sideBarBackgroundColor,
//     this.mainPartBackgroundColor,
//     this.selectionColor,
//     this.borderRadius,
//   });

//   @override
//   Widget build(BuildContext context) {
//     MenuListModel items = MenuListModel();

//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) => {},
//       builder: (context, state) {
//         var cubit = AppCubit.get(context);
//         return SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: SizedBox(
//             height: screenHeight,
//             child: Scaffold(
//               body: Stack(
//                 alignment: Alignment.centerLeft,
//                 children: [
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     physics: const NeverScrollableScrollPhysics(),
//                     child: Column(
//                       children: [
//                         // Expanded(
//                         //   child: Container(
//                         //     width: screenWidth,
//                         //     color: sideBarBackgroundColor ?? mainGreyColor,
//                         //   ),
//                         // ),
//                         Expanded(
//                           child: Container(
//                             width: screenWidth,
//                             color: mainPartBackgroundColor ?? whiteColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     physics: const BouncingScrollPhysics(),
//                     child: SizedBox(
//                       width: screenWidth,
//                       child: Row(
//                         children: [
//                           Container(
//                             width: sideBarWidth,
//                             height: screenHeight,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadiusDirectional.only(
//                                   bottomEnd:
//                                       Radius.circular(borderRadius ?? 45)),
//                               color: sideBarBackgroundColor ?? mainGreyColor,
//                             ),
//                             child: Padding(
//                               padding: isLogin
//                                   ? const EdgeInsets.only(top: 0)
//                                   : const EdgeInsets.only(top: 35),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   if (!isLogin)
//                                     Center(
//                                       child: CircleAvatar(
//                                         radius: 35,
//                                         backgroundColor: mainGreyColor,
//                                         child: Image.asset(
//                                           AppImageAsset.appIcon,
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                     ),
//                                   if (!isLogin)
//                                     Padding(
//                                       padding: const EdgeInsetsDirectional.only(
//                                           top: 30.0, start: 8),
//                                       child: ListView.separated(
//                                         shrinkWrap: true,
//                                         physics:
//                                             const NeverScrollableScrollPhysics(),
//                                         itemBuilder: (context, index) =>
//                                             menuItemBuilder(
//                                                 context, index, items, cubit),
//                                         separatorBuilder: (context, index) =>
//                                             const SizedBox(
//                                           height: 1,
//                                         ),
//                                         itemCount: items.items.length,
//                                       ),
//                                     ),
//                                   if (isLogin)
//                                     Container(
//                                       width: max(350, screenWidth / 2),
//                                       height: screenHeight,
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadiusDirectional.only(
//                                                 bottomEnd: Radius.circular(
//                                                     borderRadius ?? 45)),
//                                         color:
//                                             selectionColor ?? mainYellowColor,
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 100, horizontal: 80),
//                                         child: Image.asset(
//                                           AppImageAsset.login_image,
//                                           fit: BoxFit.fitWidth,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadiusDirectional.only(
//                                     topStart:
//                                         Radius.circular(borderRadius ?? 45.0)),
//                                 color: mainPartBackgroundColor ?? whiteColor,
//                               ),
//                               child: cubit.screens[cubit.selectedScreenIndex],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class MenuItemModel {
//   String name;
//   IconData iconData;
//   MenuItemModel({
//     required this.name,
//     required this.iconData,
//   });
// }

// class MenuListModel {
//   List<MenuItemModel> items = [];

//   MenuListModel() {
//     items.add(MenuItemModel(
//       name: "الصفحة الرئيسية",
//       iconData: Icons.home_outlined,
//     ));
//     items.add(MenuItemModel(
//       name: "الفروع",
//       iconData: Icons.keyboard_return,
//     ));
//     items.add(MenuItemModel(
//       name: "الموظفين",
//       iconData: Icons.person_2_outlined,
//     ));
//     items.add(MenuItemModel(
//       name: "الحجوزات",
//       iconData: Icons.table_chart_outlined,
//     ));
//     items.add(MenuItemModel(
//       name: "العملاء",
//       iconData: Icons.person_outlined,
//     ));
//     items.add(MenuItemModel(
//       name: "العروض",
//       iconData: Icons.panorama_fish_eye_rounded,
//     ));
//     items.add(MenuItemModel(
//       name: "الإعلانات",
//       iconData: Icons.post_add_sharp,
//     ));
//     items.add(MenuItemModel(
//       name: "الإعدادات",
//       iconData: Icons.settings,
//     ));
//   }
// }

// Widget menuItemBuilder(
//   BuildContext context,
//   int index,
//   MenuListModel list,
//   AppCubit cubit,
// ) {
//   return InkWell(
//     onTap: () {
//       cubit.updateSelected(index);
//     },
//     child: Container(
//       height: 48,
//       decoration: BoxDecoration(
//         color: index == cubit.selectedScreenIndex
//             ? mainYellowColor
//             : Colors.transparent,
//         borderRadius: const BorderRadiusDirectional.only(
//           topStart: Radius.circular(40.0),
//           bottomStart: Radius.circular(40.0),
//         ),
//       ),
//       child: ClipRRect(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Icon(
//                 list.items[index].iconData,
//                 size: 26,
//                 color: index == cubit.selectedScreenIndex
//                     ? blackColor
//                     : Colors.white,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 list.items[index].name,
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w800,
//                   fontFamily: "Cairo",
//                   color: index == cubit.selectedScreenIndex
//                       ? blackColor
//                       : Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }





















// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:manicann/core/components/app_cubit/cubit.dart';
// import 'package:manicann/core/components/app_cubit/states.dart';
// import 'package:manicann/core/constance/appImgaeAsset.dart';
// import 'package:sizer/sizer.dart';

// import '../theme/app_colors.dart';

// class DashboardPageBuilder extends StatelessWidget {
//   final double screenWidth;
//   final double screenHeight;
//   final double sideBarWidth;
//   final Widget pageContent;
//   final bool isLogin;
//   final Color? sideBarBackgroundColor;
//   final Color? mainPartBackgroundColor;
//   final Color? selectionColor;
//   final double? borderRadius;

//   const DashboardPageBuilder({
//     super.key,
//     required this.screenWidth,
//     required this.screenHeight,
//     required this.sideBarWidth,
//     required this.pageContent,
//     required this.isLogin,
//     this.sideBarBackgroundColor,
//     this.mainPartBackgroundColor,
//     this.selectionColor,
//     this.borderRadius,
//   });

//   @override
//   Widget build(BuildContext context) {
//     MenuListModel items = MenuListModel();

//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) => {},
//       builder: (context, state) {
//         var cubit = AppCubit.get(context);
//         return SizedBox(
//           height: screenHeight,
//           child: Scaffold(
//             body: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               child: SizedBox(
//                 width: screenWidth,
//                 height: screenHeight,
//                 child: Row(
//                   children: [
//                     Container(
//                       width: sideBarWidth,
//                       height: screenHeight,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadiusDirectional.only(
//                             bottomEnd: Radius.circular(borderRadius ?? 45)),
//                         color: sideBarBackgroundColor ?? mainGreyColor,
//                       ),
//                       child: Padding(
//                         padding: isLogin
//                             ? const EdgeInsets.only(top: 0)
//                             : const EdgeInsets.only(top: 35),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             if (!isLogin)
//                               Center(
//                                 child: CircleAvatar(
//                                   radius: 35,
//                                   backgroundColor: mainGreyColor,
//                                   child: Image.asset(AppImageAsset.logo),
//                                 ),
//                               ),
//                             if (!isLogin)
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(top: 30.0, left: 8),
//                                 child: ListView.separated(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemBuilder: (context, index) =>
//                                       menuItemBuilder(
//                                           context, index, items, cubit),
//                                   separatorBuilder: (context, index) =>
//                                       const SizedBox(
//                                     height: 1,
//                                   ),
//                                   itemCount: items.items.length,
//                                 ),
//                               ),
//                             if (isLogin)
//                               Container(
//                                 width: max(350, screenWidth / 2),
//                                 height: screenHeight,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadiusDirectional.only(
//                                       bottomEnd:
//                                           Radius.circular(borderRadius ?? 45)),
//                                   color: selectionColor ?? mainYellowColor,
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 100, horizontal: 80),
//                                   child: Image.asset(
//                                     "assets/images/login_image.png",
//                                     fit: BoxFit.fitWidth,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: 100.w,
//                         // height: 100.h,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadiusDirectional.only(
//                               topStart: Radius.circular(borderRadius ?? 45.0)),
//                           color: mainPartBackgroundColor ?? whiteColor,
//                         ),
//                         child: cubit.screens[cubit.selectedScreenIndex],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// /*
// Widget dashboardPageBuilder({
//   required AppCubit cubit,
//   required double screenWidth,
//   required double screenHeight,
//   required double sideBarWidth,
//   required Widget pageContent,
//   Color sideBarBackgroundColor = mainGreyColor,
//   Color mainPartBackgroundColor = whiteColor,
//   Color selectionColor = mainYellowColor,
//   double borderRadius = 45,
//   bool isLogin = false,
// }) {
//   MenuListModel items = MenuListModel();
//   return SingleChildScrollView(
//     physics: const BouncingScrollPhysics(),
//     child: SizedBox(
//       height: screenHeight,
//       child: Scaffold(
//         body: Stack(
//           alignment: Alignment.centerLeft,
//           children: [
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               physics: const NeverScrollableScrollPhysics(),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       width: screenWidth,
//                       color: sideBarBackgroundColor ?? mainGreyColor,
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       width: screenWidth,
//                       color: mainPartBackgroundColor ?? whiteColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               child: SizedBox(
//                 width: screenWidth,
//                 child: Row(
//                   children: [
//                     Container(
//                       width: sideBarWidth,
//                       height: screenHeight,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadiusDirectional.only(
//                             bottomEnd: Radius.circular(borderRadius ?? 45)),
//                         color: sideBarBackgroundColor ?? mainGreyColor,
//                       ),
//                       child: Padding(
//                         padding: isLogin
//                             ? const EdgeInsets.only(top: 0)
//                             : const EdgeInsets.only(top: 35),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             if (!isLogin)
//                               Center(
//                                 child: CircleAvatar(
//                                   radius: 35,
//                                   backgroundColor: mainYellowColor,
//                                 ),
//                               ),
//                             if (!isLogin)
//                               Padding(
//                                 padding:
//                                 const EdgeInsets.only(top: 30.0, left: 8),
//                                 child: ListView.separated(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemBuilder: (context, index) =>
//                                       menuItemBuilder(
//                                           context, index, items, cubit),
//                                   separatorBuilder: (context, index) =>
//                                   const SizedBox(
//                                     height: 1,
//                                   ),
//                                   itemCount: items.items.length,
//                                 ),
//                               ),
//                             if (isLogin)
//                               Container(
//                                 width: max(350, screenWidth / 2),
//                                 height: screenHeight,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadiusDirectional.only(
//                                       bottomEnd:
//                                       Radius.circular(borderRadius ?? 45)),
//                                   color: selectionColor ?? mainYellowColor,
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 100, horizontal: 80),
//                                   child: Image.asset(
//                                     "assets/images/login_image.png",
//                                     fit: BoxFit.fitWidth,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadiusDirectional.only(
//                               topStart: Radius.circular(borderRadius ?? 45.0)),
//                           color: mainPartBackgroundColor ?? whiteColor,
//                         ),
//                         child: pageContent,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }*/

// class MenuItemModel {
//   String name;
//   IconData iconData;
//   MenuItemModel({
//     required this.name,
//     required this.iconData,
//   });
// }

// class MenuListModel {
//   List<MenuItemModel> items = [];

//   MenuListModel() {
//     items.add(MenuItemModel(
//       name: "Dashboard",
//       iconData: Icons.home_outlined,
//     ));
//     items.add(MenuItemModel(
//       name: "Branches",
//       iconData: Icons.keyboard_return,
//     ));
//     items.add(MenuItemModel(
//       name: "Employees",
//       iconData: Icons.person_2_outlined,
//     ));
//     items.add(MenuItemModel(
//       name: "Bookings",
//       iconData: Icons.table_chart_outlined,
//     ));
//     items.add(MenuItemModel(
//       name: "Customers",
//       iconData: Icons.person_outlined,
//     ));
//     items.add(MenuItemModel(
//       name: "Promo",
//       iconData: Icons.panorama_fish_eye_rounded,
//     ));
//     items.add(MenuItemModel(
//       name: "Posts",
//       iconData: Icons.post_add_sharp,
//     ));
//     items.add(MenuItemModel(
//       name: "Settings",
//       iconData: Icons.settings,
//     ));
//   }
// }

// Widget menuItemBuilder(
//   BuildContext context,
//   int index,
//   MenuListModel list,
//   AppCubit cubit,
// ) {
//   return InkWell(
//     onTap: () {
//       cubit.updateSelected(index);
//     },
//     child: Container(
//       height: 48,
//       decoration: BoxDecoration(
//         color: index == cubit.selectedScreenIndex
//             ? mainYellowColor
//             : Colors.transparent,
//         borderRadius: const BorderRadiusDirectional.only(
//           topStart: Radius.circular(40.0),
//           bottomStart: Radius.circular(40.0),
//         ),
//       ),
//       child: ClipRRect(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Icon(
//                 list.items[index].iconData,
//                 size: 26,
//                 color: index == cubit.selectedScreenIndex
//                     ? blackColor
//                     : Colors.white,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 list.items[index].name,
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: "Cairo",
//                   color: index == cubit.selectedScreenIndex
//                       ? blackColor
//                       : Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
