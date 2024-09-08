import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_cache_image.dart';
import 'package:manicann/core/components/delete_dialog.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/shared_screen/no_data_screen.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/app_theme.dart';
import 'package:manicann/features/before_after/presentation/bloc/cubit/before_after_state.dart';
import 'package:manicann/features/before_after/presentation/bloc/cubit/before_after_cubit.dart';
import 'package:manicann/features/before_after/presentation/pages/add_before_after_screen.dart';
import 'package:manicann/shared_screen/main_layout_screen.dart';
import 'package:sizer/sizer.dart';

class BeforeAfterScreen extends StatefulWidget {
  const BeforeAfterScreen({
    super.key,
  });

  @override
  _BeforeAfterScreenState createState() => _BeforeAfterScreenState();
}

class _BeforeAfterScreenState extends State<BeforeAfterScreen> {
  int currentPage = 0;
  final int itemsPerPage = 10;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeforeAfterBloc, BeforeAfterState>(
      builder: (context, state) {
        BeforeAfterBloc bloc = BlocProvider.of<BeforeAfterBloc>(context);
        Widget pageContent;

        if (state is ErrorBeforeAfterState) {
          pageContent = MyErrorWidget(
            text: state.message,
            onTap: () {
              bloc.getAllData();
            },
          );
        } else if (state is LoadingBeforeAfterState || isLoading) {
          pageContent = const LoadingWidget();
        } else {
          int totalPages = (bloc.data.length / itemsPerPage).ceil();
          pageContent = Container(
            width: 80.w,
            // height: 100.h,
            constraints: BoxConstraints(maxHeight: 120.h, minHeight: 103.h),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RowForHeaderBeforeAfter(),
                SizedBox(height: 2.h),
                bloc.data.isEmpty
                    ? const EmptyScreen()
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        constraints:
                            BoxConstraints(maxHeight: 79.5.h, minHeight: 30.h),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1.5.w,
                                  mainAxisSpacing: 2.h,
                                  childAspectRatio: 1 / 0.49),
                          itemBuilder: (context, index) {
                            final actualIndex =
                                currentPage * itemsPerPage + index;
                            if (actualIndex >= bloc.data.length) return null;
                            return BeforeAfterWidget(
                              numberOfInterActions: bloc
                                  .data[actualIndex].reactionsCount
                                  .toString(),
                              beforeImageUrl: AppLink.imageBaseUrl +
                                  bloc.data[actualIndex].before!.image,
                              afterImageUrl: AppLink.imageBaseUrl +
                                  bloc.data[actualIndex].after!.image,
                              description: bloc.data[actualIndex].description!,
                              onDelete: () {
                                showDialog(
                                  context: context,
                                  builder: (contextc) {
                                    return CustomDialog(
                                      color: Colors.red,
                                      function: () async {
                                        Navigator.of(context).pop();
                                        await bloc.deleteData(
                                            bloc.data[actualIndex].id
                                                .toString(),
                                            context);
                                      },
                                      text: 'تأكيد حذف عملية قبل وبعد ؟',
                                    );
                                  },
                                );
                              },
                              onEdit: () {
                                bloc.editData(
                                    bloc.data[actualIndex].id.toString());
                              },
                            );
                          },
                          itemCount: (bloc.data.length -
                                      currentPage * itemsPerPage) >
                                  itemsPerPage
                              ? itemsPerPage
                              : (bloc.data.length - currentPage * itemsPerPage),
                        ),
                      ),
                SizedBox(height: 1.h),
                bloc.data.isEmpty
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, size: 20),
                            onPressed: currentPage > 0
                                ? () {
                                    setState(() {
                                      currentPage--;
                                      isLoading = !isLoading;
                                    });
                                    Future.delayed(Duration(
                                            milliseconds:
                                                Random().nextInt(500) + 500))
                                        .then((value) {
                                      setState(() {
                                        isLoading = !isLoading;
                                      });
                                    });
                                  }
                                : null,
                          ),
                          ...List.generate(totalPages, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0.3.w),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    currentPage = index;
                                    isLoading = !isLoading;
                                  });
                                  Future.delayed(Duration(
                                          milliseconds:
                                              Random().nextInt(500) + 500))
                                      .then((value) {
                                    setState(() {
                                      isLoading = !isLoading;
                                    });
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: currentPage == index
                                      ? AppColors.primary
                                      : Colors.grey,
                                ),
                                child: Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios, size: 20),
                            onPressed: currentPage < totalPages - 1
                                ? () {
                                    setState(() {
                                      currentPage++;
                                      isLoading = !isLoading;
                                    });
                                    Future.delayed(Duration(
                                            milliseconds:
                                                Random().nextInt(500) + 500))
                                        .then((value) {
                                      setState(() {
                                        isLoading = !isLoading;
                                      });
                                    });
                                  }
                                : null,
                          ),
                        ],
                      ),
              ],
            ),
          );
        }
        return MainLayoutScreen(
          pageContent: pageContent,
        );
      },
    );
  }
}

class RowForHeaderBeforeAfter extends StatelessWidget {
  const RowForHeaderBeforeAfter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "قبل وبعد",
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
              showDialog(
                context: context,
                builder: (context) {
                  return const AddBeforeAfterScreen();
                },
              );
            },
            text: 'إضافة قبل وبعد',
          ),
        ],
      ),
    );
  }
}

class BeforeAfterWidget extends StatelessWidget {
  final String beforeImageUrl;
  final String afterImageUrl;
  final String description;
  final String numberOfInterActions;
  final void Function()? onEdit;
  final void Function()? onDelete;

  const BeforeAfterWidget({
    super.key,
    required this.beforeImageUrl,
    required this.afterImageUrl,
    required this.description,
    this.onEdit,
    this.onDelete,
    required this.numberOfInterActions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shadowColor: Colors.black54,
      // margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardForBeforeOrAfter(
                  imageUrl: beforeImageUrl,
                  text: 'قبل',
                ),
                SizedBox(width: 2.w),
                CardForBeforeOrAfter(
                  imageUrl: afterImageUrl,
                  text: 'بعد',
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      Text(
                        description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const IconButton(
                      icon: Icon(
                        Icons.favorite_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: null,
                    ),
                    Text(
                      numberOfInterActions,
                      style: textTheme.labelLarge!.copyWith(color: Colors.red),
                    ),
                  ],
                ),
                // SizedBox(width: 1.w),
                // IconButton(
                //   icon: const Icon(
                //     Icons.edit_outlined,
                //     color: Colors.black54,
                //     size: 20,
                //   ),
                //   onPressed: onEdit,
                // ),
                SizedBox(width: 1.w),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardForBeforeOrAfter extends StatelessWidget {
  const CardForBeforeOrAfter({
    super.key,
    required this.imageUrl,
    required this.text,
  });

  final String imageUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              SizedBox(height: 5.h),
              SizedBox(
                width: 15.w,
                height: 20.h,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 1.0,
                  child: CustomCacheImage(imageUrl: imageUrl),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0.h,
            child: Text(
              text,
              style: textTheme.labelLarge!.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
