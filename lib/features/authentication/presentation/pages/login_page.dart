import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/di/appInitializer.dart';
import 'package:manicann/features/authentication/presentation/bloc/cubit.dart';
import 'package:manicann/features/authentication/presentation/bloc/states.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/dashboard_builder.dart';
import '../../../../core/constance/appImgaeAsset.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/login_test_field.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController emailController =
      TextEditingController(text: 'admin@admin.com');
  TextEditingController passController =
      TextEditingController(text: 'password');
  var formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is SuccessLoginState) {
          CustomToast t =
              const CustomToast(type: "Success", msg: "تم تسجيل الدخول بنجاح");
          t(context);
          AppCubit cubit = AppCubit.get(context);
          AppInitializer.isHaveAuth = true;
          cubit.initialListScreen();
          cubit.updateSelected(cubit.selectedScreenIndex);
          // navigateTo(context, cubit.screens[cubit.selectedScreenIndex]);
          //Navigator.pop(context);
        }
        if (state is ErrorLoginState) {
          CustomToast t =
              const CustomToast(type: "Error", msg: "المعطيات غير صحيحة");
          t(context);
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        double screenWidth = max(MediaQuery.of(context).size.width, 700);
        double screenHeight = max(MediaQuery.of(context).size.height, 650);
        Widget pageContent = Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 15, vertical: 60),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    AppImageAsset.logo,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: double.infinity,
                  child: loginTextFormField(
                    controller: emailController,
                    hintText: "مثال: name@mail.com",
                    labelText: "البريد الإلكتروني",
                    prefix: Icons.mail_outline,
                    validate: (value) {
                      if (value!.isEmpty) {
                        CustomToast t = const CustomToast(
                            type: "Warning", msg: "يجب ملء البريد الإلكتروني");
                        t(context);
                        return "";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: loginTextFormField(
                    controller: passController,
                    hintText: "ستة محارف على الأقل",
                    labelText: "كلمة السر",
                    prefix: Icons.lock_outline,
                    isPassword: cubit.isLoginPasswordHidden,
                    suffix: Icons.remove_red_eye,
                    showPass: () => cubit.changeLoginPasswordState(),
                    suffixColor: mainYellowColor,
                    validate: (value) {
                      if (value!.isEmpty) {
                        CustomToast t = const CustomToast(
                            type: "Warning",
                            msg: "كلمة السر لا يجب أن تكون فارغة");
                        t(context);
                        return '';
                      } else if (value.length < 6) {
                        CustomToast t = const CustomToast(
                            type: "Warning", msg: "كلمة السر قصيرة جداً");
                        t(context);
                        return '';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth / 11),
                    child: ConditionalBuilder(
                      condition: state is! LoadingLoginState,
                      builder: (context) {
                        return myButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.login(
                                  context: context,
                                  email: emailController.text,
                                  password: passController.text);
                            }
                          },
                          text: "تسحيل الدخول",
                          height: 35,
                          width: double.infinity,
                          backgroundColor: mainYellowColor,
                        );
                      },
                      fallback: (context) {
                        return const LoadingWidget();
                      },
                    )),
              ],
            ),
          ),
        );

        return DashboardPageBuilder(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          sideBarWidth: screenWidth / 2,
          pageContent: pageContent,
          isLogin: true,
          mainPartBackgroundColor: whiteColor,
          sideBarBackgroundColor: mainYellowColor,
        );
      },
    );
  }
}
