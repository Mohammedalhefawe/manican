import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/constance/appImgaeAsset.dart';
import 'package:manicann/features/employees/domain/entities/service.dart';
import 'package:manicann/features/employees/presentation/bloc/cubit.dart';
import 'package:manicann/features/employees/presentation/bloc/states.dart';
import 'package:manicann/features/employees/presentation/pages/employees_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/check_box_builder.dart';
import '../../../../core/components/custom_textfiled.dart';
import '../../../../core/components/dashboard_builder.dart';
import '../../../../core/components/page_label.dart';
import '../../../../core/constance/appLink.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/font_styles.dart';

PageController pageController = PageController();

// ignore: must_be_immutable
class AddEmployeeScreen extends StatelessWidget {
  bool isEdit;
  AddEmployeeScreen({super.key, this.isEdit = false});

  TextEditingController firstNameController = TextEditingController();
  TextEditingController midNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController ratioController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool firstEditCall = true;
  bool validInput = true;
  var formKey1 = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesCubit, EmployeesStates>(
      listener: (context, state) {
        if (state is GetEmployeesErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
        if (state is GetServicesErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
        if (state is AddEmployeeSuccessState) {
          EmployeesCubit.get(context)
              .getAllEmployees(int.parse(AppLink.branchId));
          Future.delayed(const Duration(seconds: 1), () {
            CustomToast t = const CustomToast(
                type: "Success", msg: "تم إضافة الموظف بنجاح");
            t(context);
            // navigateAndFinish(context, const EmployeesScreen());
            var cubit = AppCubit.get(context);
            if (AppLink.role == 'admin') {
              cubit.screens[2] = const EmployeesScreen();
            } else {
              cubit.screens[1] = const EmployeesScreen();
            }
            cubit.emit(ScreenNavigationState());
          });
        }
        if (state is AddEmployeeErrorState) {
          CustomToast t = CustomToast(type: "ُError", msg: state.error);
          t(context);
        }
        if (state is AddEmployeeEmptyFieldsWarningState) {
          CustomToast t = CustomToast(type: "Warning", msg: state.error);
          t(context);
        }
        if (state is EmployeesAddProfilePictureErrorState) {
          CustomToast t = const CustomToast(
              type: "Warning",
              msg: "حدث خلل بتحميل الصورة.. أعد المحاولة مجدداً");
          t(context);
        }
        if (state is EditEmployeeNothingChangedState) {
          CustomToast t = const CustomToast(
              type: "Warning", msg: "لم يتم تغيير أي من القيم");
          t(context);
        }
        if (state is EditEmployeeSuccessState) {
          EmployeesCubit.get(context)
              .getAllEmployees(int.parse(AppLink.branchId));
          Future.delayed(const Duration(seconds: 1, milliseconds: 200), () {
            CustomToast t = const CustomToast(
                type: "Success", msg: "تم تعديل بيانات الموظف بنجاح");
            t(context);
            var cubit = AppCubit.get(context);
            if (AppLink.role == 'admin') {
              cubit.screens[2] = const EmployeesScreen();
            } else {
              cubit.screens[1] = const EmployeesScreen();
            }
            cubit.emit(ScreenNavigationState());
            // navigateAndFinish(context, const EmployeesScreen());
          });
        }
        if (state is EditEmployeeErrorState) {
          CustomToast t = CustomToast(type: "ُError", msg: state.error);
          t(context);
        }
      },
      builder: (context, state) {
        var cubit = EmployeesCubit.get(context);
        double screenWidth = max(MediaQuery.of(context).size.width, 800);
        double screenHeight = MediaQuery.of(context).size.height;
        double sideBarWidth = 210;
        if (isEdit && cubit.selectedEmployeeToEdit != null && firstEditCall) {
          firstNameController.text =
              cubit.selectedEmployeeToEdit!.firstName ?? "";
          midNameController.text =
              cubit.selectedEmployeeToEdit!.middleName ?? "";
          lastNameController.text =
              cubit.selectedEmployeeToEdit!.lastName ?? "";
          phoneNumberController.text =
              cubit.selectedEmployeeToEdit!.phoneNumber ?? "";
          nationalIdController.text =
              cubit.selectedEmployeeToEdit!.nationalId ?? "";
          pinController.text = "${cubit.selectedEmployeeToEdit!.pin ?? ""}";
          emailController.text = cubit.selectedEmployeeToEdit!.email ?? "";
          passwordController.text =
              cubit.selectedEmployeeToEdit!.password ?? "";
          salaryController.text =
              "${cubit.selectedEmployeeToEdit!.salary ?? ""}";
          ratioController.text = "${cubit.selectedEmployeeToEdit!.ratio ?? ""}";

          int index = 0;
          for (int i = 0; i < cubit.jobPositions.length; i++) {
            if (cubit.selectedEmployeeToEdit!.position != null) {
              if (cubit.selectedEmployeeToEdit!.position ==
                  cubit.jobPositions[i]) {
                index = i;
                break;
              }
            }
          }
          cubit.selectJobPosition(index);
          if (index == 0) {
            if (cubit.selectedEmployeeToEdit!.isFixed! == true) {
              cubit.selectSalaryType(0);
            } else {
              cubit.selectSalaryType(1);
            }
          }
          if (index == 0 || index == 2) {
            cubit.selectedServices = [];
            if (cubit.selectedEmployeeToEdit!.services != null) {
              for (var element in cubit.selectedEmployeeToEdit!.services!) {
                cubit.selectedServices
                    .add(ServiceEntity(id: element.id, name: element.name));
              }
            }
          }

          firstEditCall = false;
        }
        if (cubit.selectedJobPosition == 2 || salaryController.text.isEmpty) {
          salaryController.text = "0";
        }
        if (ratioController.text.isEmpty) {
          ratioController.text = "0";
        }
        ImageProvider<Object>? getImage() {
          if (cubit.editImageBytes != null) {
            try {
              print("we tried to upload");
              return Image.memory(cubit.editImageBytes!).image;
            } catch (e) {
              print("we failed to upload");
              return Image.asset(AppImageAsset.defaultUserImage).image;
            }
          } else {
            if (cubit.selectedEmployeeToEdit!.image == null) {
              print("neither selected nor has an image");
              return Image.asset(AppImageAsset.defaultUserImage).image;
            } else {
              print("trying to download");
              try {
                var image = Image.network("${AppLink.baseImageUrl}"
                        "${cubit.selectedEmployeeToEdit!.image?.image}")
                    .image;
                return image;
              } catch (e) {
                return Image.asset(AppImageAsset.defaultUserImage).image;
              }
            }
          }
        }

        Widget pageContent = SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxHeight: 110.h, minHeight: 105.h),
            width: screenWidth,
            height: screenHeight,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      onPressed: () {
                        var cubit = AppCubit.get(context);
                        if (AppLink.role == 'admin') {
                          cubit.screens[2] = const EmployeesScreen();
                        } else {
                          cubit.screens[1] = const EmployeesScreen();
                        }
                        cubit.emit(ScreenNavigationState());
                      },
                      icon: const Icon(
                        Icons.arrow_back_sharp,
                        color: blackColor,
                        size: 20,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  pageLabelBuilder(
                      label: !isEdit ? "إضافة موظف" : "تعديل موظف"),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: screenHeight,
                      child: PageView(
                        controller: pageController,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          cubit.addEmpPageChange(index);
                        },
                        children: [
                          Form(
                            key: formKey1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'الصورة الشخصية',
                                        style: textFieldLabelStyle,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          if (!isEdit)
                                            CircleAvatar(
                                              radius: 70,
                                              backgroundImage: cubit
                                                          .imageBytes !=
                                                      null
                                                  ? Image.memory(
                                                          cubit.imageBytes!)
                                                      .image
                                                  : const AssetImage(
                                                      AppImageAsset
                                                          .defaultUserImage),
                                            ),
                                          if (isEdit)
                                            CircleAvatar(
                                              radius: 70,
                                              backgroundImage: getImage(),
                                            ),
                                          IconButton(
                                            onPressed: () {
                                              if (!isEdit) {
                                                cubit
                                                    .addEmployeeProfilePicture();
                                              }
                                              if (isEdit) {
                                                cubit
                                                    .editEmployeeProfilePicture();
                                              }
                                            },
                                            icon: const CircleAvatar(
                                              radius: 12,
                                              backgroundColor: mainYellowColor,
                                              child: Icon(
                                                Icons.add,
                                                size: 20,
                                                color: whiteColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomTextFiled(
                                      hintText: "الاسم الأول",
                                      controller: firstNameController,
                                      width: double.infinity,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "لا يجوز أن يكون هذا الحقا فارغا ";
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Expanded(
                                      child: CustomTextFiled(
                                        hintText: "اسم الأب",
                                        controller: midNameController,
                                        width: double.infinity,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "لا يجوز أن يكون هذا الحقا فارغا ";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFiled(
                                        hintText: "العائلة",
                                        controller: lastNameController,
                                        width: double.infinity,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "لا يجوز أن يكون هذا الحقا فارغا ";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Expanded(
                                      child: CustomTextFiled(
                                        hintText: "رقم الهاتف",
                                        isDigit: true,
                                        controller: phoneNumberController,
                                        width: double.infinity,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "لا يجوز أن يكون هذا الحقا فارغا ";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFiled(
                                        hintText: "الرقم الوطني",
                                        isDigit: true,
                                        controller: nationalIdController,
                                        width: double.infinity,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "لا يجوز أن يكون هذا الحقا فارغا ";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Expanded(
                                      child: CustomTextFiled(
                                        isDigit: true,
                                        hintText: "معرف البصامة *",
                                        controller: pinController,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MyIconButton(
                                      icon: Icons.arrow_forward,
                                      mainColor: mainYellowColor,
                                      hoverColor: brightMainYellowColor,
                                      iconSize: 28,
                                      onPressed: () {
                                        if (formKey1.currentState!.validate()) {
                                          pageController.animateToPage(
                                            1,
                                            duration: const Duration(
                                                milliseconds: 800),
                                            curve:
                                                Curves.fastEaseInToSlowEaseOut,
                                          );
                                        } else {
                                          cubit.invalidFieldErrorTrigger();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Form(
                            key: formKey2,
                            child: SizedBox(
                              width: screenWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 220,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "الوظيفة: ",
                                                style: textFieldLabelStyle,
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) =>
                                                    checkBoxBuilder(
                                                  boxLabel:
                                                      cubit.jobPositions[index],
                                                  onTap: () {
                                                    cubit.selectJobPosition(
                                                        index);
                                                  },
                                                  isSelected: cubit
                                                          .selectedJobPosition ==
                                                      index,
                                                ),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        const SizedBox(
                                                  height: 20,
                                                ),
                                                itemCount:
                                                    cubit.jobPositions.length,
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (cubit.selectedJobPosition == 0 ||
                                            cubit.selectedJobPosition == 2)
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "الخدمات المقدمة: ",
                                                  style: textFieldLabelStyle,
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    child: ListView.separated(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              checkBoxBuilder(
                                                        boxLabel: cubit
                                                            .servicesList[index]
                                                            .name,
                                                        onTap: () {
                                                          cubit
                                                              .selectServiceForEmployee(
                                                                  index);
                                                        },
                                                        isSelected: cubit
                                                            .selectedServices
                                                            .contains(cubit
                                                                    .servicesList[
                                                                index]),
                                                      ),
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              const SizedBox(
                                                        height: 20,
                                                      ),
                                                      itemCount: cubit
                                                          .servicesList.length,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (cubit.selectedJobPosition == 3)
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomTextFiled(
                                                  hintText: "البريد الإلكتروني",
                                                  controller: emailController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "لا يجوز أن يكون هذا الحقا فارغا ";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                CustomTextFiled(
                                                  hintText: "كلمة السر",
                                                  controller:
                                                      passwordController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "لا يجوز أن يكون هذا الحقا فارغا ";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "نوع الراتب: ",
                                              style: textFieldLabelStyle,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) =>
                                                  checkBoxBuilder(
                                                boxLabel:
                                                    cubit.salaryTypes[index],
                                                onTap: () {
                                                  cubit.selectSalaryType(index);
                                                },
                                                isSelected:
                                                    cubit.selectedSalaryType ==
                                                        index,
                                              ),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                height: 20,
                                              ),
                                              itemCount:
                                                  cubit.salaryTypes.length,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            if (cubit.selectedJobPosition != 2)
                                              CustomTextFiled(
                                                isDigit: true,
                                                hintText: "الراتب الثابت",
                                                controller: salaryController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "لا يجوز أن يكون هذا الحقا فارغا ";
                                                  } else {
                                                    try {
                                                      int x = int.parse(value);
                                                    } catch (error) {
                                                      return "البيانات المدخلة غير صحيحة ";
                                                    }
                                                    return null;
                                                  }
                                                },
                                              ),
                                            if (cubit.selectedJobPosition != 2)
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            if (cubit.salaryTypes[
                                                    cubit.selectedSalaryType] !=
                                                cubit.allSalaryTypes[0])
                                              CustomTextFiled(
                                                isDigit: true,
                                                hintText: "النسبة",
                                                controller: ratioController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "لا يجوز أن يكون هذا الحقا فارغا ";
                                                  } else {
                                                    try {
                                                      int x = int.parse(value);
                                                    } catch (error) {
                                                      return "البيانات المدخلة غير صحيحة ";
                                                    }
                                                    return null;
                                                  }
                                                },
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MyIconButton(
                                        icon: Icons.arrow_back,
                                        mainColor: mainYellowColor,
                                        hoverColor: brightMainYellowColor,
                                        iconSize: 28,
                                        onPressed: () {
                                          pageController.animateToPage(
                                            0,
                                            duration: const Duration(
                                                milliseconds: 800),
                                            curve:
                                                Curves.fastEaseInToSlowEaseOut,
                                          );
                                        },
                                      ),
                                      const Spacer(),
                                      myButton(
                                        backgroundColor: mainYellowColor,
                                        text: !isEdit ? "إضافة" : "تعديل",
                                        onPressed: () {
                                          if (formKey2.currentState!
                                              .validate()) {
                                            if (isEdit) {
                                              cubit.editEmployee(
                                                firstName:
                                                    firstNameController.text,
                                                middleName:
                                                    midNameController.text,
                                                lastName:
                                                    lastNameController.text,
                                                phoneNumber:
                                                    phoneNumberController.text,
                                                nationalId:
                                                    nationalIdController.text,
                                                pin: pinController.text,
                                                salary: salaryController.text,
                                                ratio: ratioController.text,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                            } else {
                                              cubit.addEmployee(
                                                firstName:
                                                    firstNameController.text,
                                                middleName:
                                                    midNameController.text,
                                                lastName:
                                                    lastNameController.text,
                                                phoneNumber:
                                                    phoneNumberController.text,
                                                nationalId:
                                                    nationalIdController.text,
                                                pin: pinController.text,
                                                salary: salaryController.text,
                                                ratio: ratioController.text,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                            }
                                          } else {
                                            cubit.invalidFieldErrorTrigger();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
