import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import '../theme/app_colors.dart';

class TablePagesSelectorBuilder extends StatelessWidget {
  final int totalPages;
  final void Function(int index)? changePageFunction;
  final int selectedPageIndex;

  const TablePagesSelectorBuilder({
    super.key,
    required this.totalPages,
    required this.changePageFunction,
    required this.selectedPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        if (totalPages > 3) {
          ScrollController scrollController = ScrollController();
          return SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onHover: (event) {
                    cubit.hoverClick(-1);
                  },
                  onExit: (event) {
                    cubit.cancelHoverClick(-1);
                  },
                  child: GestureDetector(
                    onTap: () {
                      double nextOffset =
                          ((scrollController.offset - 138) / 138).floor() * 138;
                      scrollController.animateTo(
                        nextOffset,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    child: Icon(
                      Icons.arrow_left,
                      size: 28,
                      color: cubit.empTableLeftClickHovered
                          ? brightMainYellowColor
                          : mainYellowColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 128,
                  height: 60,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: scrollController,
                    child: Row(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                changePageFunction!(index + 1);
                              }, //() => cubit.changeEmpTablePage(index + 1),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: mainGreyColor,
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: selectedPageIndex ==
                                          index +
                                              1 //cubit.employeesTablePage == index + 1
                                      ? mainGreyColor
                                      : lightGrey,
                                  child: Center(
                                      child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: selectedPageIndex ==
                                              index +
                                                  1 //cubit.employeesTablePage == index + 1
                                          ? Colors.white
                                          : blackColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      fontFamily: "Cairo",
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                          itemCount: totalPages,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onHover: (event) {
                    cubit.hoverClick(1);
                  },
                  onExit: (event) {
                    cubit.cancelHoverClick(1);
                  },
                  child: GestureDetector(
                    onTap: () {
                      double nextOffset =
                          ((scrollController.offset + 138) / 138).floor() * 138;
                      scrollController.animateTo(
                        nextOffset,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    child: Icon(
                      Icons.arrow_right,
                      size: 28,
                      color: cubit.empTableRightClickHovered
                          ? brightMainYellowColor
                          : mainYellowColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 60,
              width: 128,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => changePageFunction!(
                            index + 1), //cubit.changeEmpTablePage(index + 1),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: mainGreyColor,
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: selectedPageIndex ==
                                    index +
                                        1 //cubit.employeesTablePage == index + 1
                                ? mainGreyColor
                                : lightGrey,
                            child: Center(
                                child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: selectedPageIndex ==
                                        index +
                                            1 //cubit.employeesTablePage == index + 1
                                    ? Colors.white
                                    : blackColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                fontFamily: "Cairo",
                              ),
                            )),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    itemCount: totalPages,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 36,
            ),
          ],
        );
      },
    );
  }
}
