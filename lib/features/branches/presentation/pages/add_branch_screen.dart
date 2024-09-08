import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_textfiled.dart';
import 'package:manicann/core/components/custom_textfiled_Time.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/function/time_formatter.dart';
import 'package:manicann/core/function/validinput.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/font_styles.dart';
import 'package:manicann/features/branches/domain/entities/branch_entity.dart';
import 'package:manicann/features/branches/presentation/bloc/branches_bloc/branches_bloc.dart';
import 'package:manicann/features/branches/presentation/bloc/branches_bloc/branches_state.dart';
import 'package:manicann/features/branches/presentation/pages/all_branches_screen.dart';
import 'package:manicann/features/branches/presentation/widgets/select_days_widget.dart';
import 'package:manicann/shared_screen/main_layout_screen.dart';
import 'package:sizer/sizer.dart';

class AddBranchScreen extends StatelessWidget {
  const AddBranchScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchesBloc, BranchesState>(builder: (context, state) {
      BranchesBloc bloc = BlocProvider.of<BranchesBloc>(context);
      Widget pageContent;

      if (state is ErrorBranchesState) {
        pageContent = MyErrorWidget(
          text: state.message,
        );
      } else if (state is LoadingBranchesState) {
        pageContent = const LoadingWidget();
      } else {
        pageContent = Form(
          key: bloc.formstate,
          child: SingleChildScrollView(
            child: Container(
              width: 80.w,
              // height: 100.h,
              constraints: BoxConstraints(minHeight: 100.h, maxHeight: 110.h),
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "إضافة فرع",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      // height: 80.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'صورة الفرع',
                                    style: textFieldLabelStyle,
                                  ),
                                  SizedBox(
                                    height: 0.8.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      bloc.pickImage();
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 150,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                          color: lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: bloc.selecetImage == true
                                          ? Image.memory(
                                              bloc.webImage,
                                              fit: BoxFit.cover,
                                            )
                                          : Icon(
                                              Icons.image_outlined,
                                              size: 40,
                                              color: AppColors.black
                                                  .withOpacity(0.2),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          SizedBox(
                            width: 80.w,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextFiledWithValidate(
                                      height: !bloc.isValid ? 60 : null,
                                      validator: (val) {
                                        return vaildator(val!, 3, 30, 'name');
                                      },
                                      hintText: 'اسم الفرع',
                                      controller: bloc.controllerNameBranch),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Expanded(
                                  child: CustomTextFiledWithValidate(
                                      height: !bloc.isValid ? 60 : null,
                                      validator: (val) {
                                        return vaildator(val!, 3, 30, 'name');
                                      },
                                      hintText: 'الموقع',
                                      controller: bloc.controllerLocation),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          SizedBox(
                            width: 80.w,
                            child: Row(
                              children: [
                                Expanded(child: SelectTimeWidget(bloc: bloc)),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Expanded(
                                  child: CustomTextFiledWithValidate(
                                      height: !bloc.isValid ? 60 : null,
                                      validator: (val) {
                                        return vaildator(val!, 3, 30, 'name');
                                      },
                                      hintText: 'الوصف',
                                      controller: bloc.controllerDescription),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'أيام العمل',
                                style: textFieldLabelStyle,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              const WorkDaysSelection(),
                              // SizedBox(
                              //   height: 1.h,
                              // ),
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
                                          var cubit = AppCubit.get(context);
                                          cubit.screens[1] =
                                              const BranchesScreen();
                                          cubit.emit(ScreenNavigationState());
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
                                          bloc.addBranch(context);
                                        },
                                        text: 'إضافة'),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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

BranchEntity branchEntityData(BranchesBloc bloc) {
  print(bloc.startTime);
  return BranchEntity(
      name: bloc.controllerNameBranch.text.toString(),
      description: bloc.controllerDescription.text.toString(),
      location: bloc.controllerLocation.text.toString(),
      startTime: convertTimeFormatForBackEnd(bloc.startTime ?? "1:00 PM"),
      endTime: convertTimeFormatForBackEnd(bloc.endTime ?? "2:00 PM"),
      wokingDays: bloc.selectedWorkDays,
      image: bloc.webImage,
      filePath: bloc.pickedImage!.path);
}

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({
    super.key,
    required this.bloc,
  });

  final BranchesBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFiledForTime(
              height: !bloc.isValid ? 60 : null,
              validator: (val) {
                return vaildator(val!, 3, 30, 'name');
              },
              onTap: () {
                bloc.selectStartTime(context);
              },
              hintText: 'وقت البداية',
              controller: TextEditingController(text: bloc.startTime ?? "")),
        ),
        SizedBox(
          width: 0.5.w,
        ),
        Expanded(
          child: CustomTextFiledForTime(
              height: !bloc.isValid ? 60 : null,
              validator: (val) {
                return vaildator(val!, 3, 30, 'name');
              },
              onTap: () {
                bloc.selectEndTime(context);
              },
              hintText: 'وقت النهاية',
              controller: TextEditingController(text: bloc.endTime ?? "")),
        ),
      ],
    );
  }
}
