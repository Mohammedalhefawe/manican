import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/shared_screen/no_data_screen.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/branches/presentation/bloc/branches_bloc/branches_bloc.dart';
import 'package:manicann/features/branches/presentation/bloc/branches_bloc/branches_state.dart';
import 'package:manicann/features/branches/presentation/pages/add_branch_screen.dart';
import 'package:manicann/features/branches/presentation/widgets/branch_widget.dart';
import 'package:manicann/shared_screen/main_layout_screen.dart';
import 'package:sizer/sizer.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchesBloc, BranchesState>(
        buildWhen: (previous, current) {
      return true;
    }, builder: (context, state) {
      BranchesBloc bloc = BlocProvider.of<BranchesBloc>(context);
      Widget pageContent;
      if (state is ErrorBranchesState) {
        pageContent = MyErrorWidget(
          text: state.message,
          onTap: () {
            bloc.getAllBranches();
          },
        );
      } else if (state is LoadingBranchesState) {
        pageContent = const LoadingWidget();
      } else {
        pageContent = bloc.data.isEmpty
            ? const EmptyScreen()
            : SingleChildScrollView(
                child: Container(
                  width: 80.w,
                  // height: 100.h,
                  // constraints: BoxConstraints(maxHeight: 110.h, minHeight: 101.h),

                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "الأفرع",
                              style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            myButton(
                                width: 20.w,
                                elevation: 0,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                backgroundColor: AppColors.primary,
                                onPressed: () {
                                  var cubit = AppCubit.get(context);
                                  cubit.screens[1] = const AddBranchScreen();
                                  cubit.emit(ScreenNavigationState());
                                },
                                text: 'إضافة فرع جديد')
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        BlocBuilder<BranchesBloc, BranchesState>(
                            builder: (context, state) {
                          var bloc = BlocProvider.of<BranchesBloc>(context);
                          return Container(
                            constraints: BoxConstraints(
                                maxHeight: 85.h, minHeight: 80.h),
                            child: ScrollConfiguration(
                              behavior: NoScrollGlowBehavior(),
                              child: GridView.builder(
                                // physics: const NeverScrollableScrollPhysics(),
                                // shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 7.w,
                                  mainAxisSpacing: 5.h,
                                  childAspectRatio: 1 / 1,
                                ),
                                itemBuilder: (context, index) {
                                  return BranchWidget(
                                    onTap: () {
                                      bloc.changeBrancheSelected(
                                          index, context);
                                    },
                                    selected: AppLink.branchId ==
                                        bloc.data[index].id.toString(),
                                    branchModel: bloc.data[index],
                                    index: index,
                                  );
                                },
                                itemCount: bloc.data.length,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              );
      }
      return MainLayoutScreen(
        pageContent: pageContent,
      );
    });
  }
}

class NoScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child; // Removes the overscroll indicator and the glowing effect.
  }
}
