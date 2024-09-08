import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_cache_image.dart';
import 'package:manicann/core/components/custom_textfiled.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/delete_dialog.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/shared_screen/no_data_screen.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/function/date_to_day_name.dart';
import 'package:manicann/core/function/time_formatter.dart';
import 'package:manicann/core/function/validinput.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/offers/presentation/bloc/offer_bloc/offer_bloc.dart';
import 'package:manicann/features/offers/presentation/bloc/offer_bloc/offer_state.dart';
import 'package:manicann/features/offers/presentation/widgets/add_image_widget.dart';
import 'package:manicann/shared_screen/main_layout_screen.dart';
import 'package:sizer/sizer.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<OffersBloc, OfferState>(listener: (context, state) {
      showToastForState(context, state);
    }, builder: (context, state) {
      // OffersBloc bloc = BlocProvider.of<OffersBloc>(context);
      Widget pageContent;
      if (state is ErrorOfferState) {
        pageContent = MyErrorWidget(
          text: state.message,
        );
      } else if (state is LoadingOfferState) {
        pageContent = const LoadingWidget();
      } else {
        pageContent = Container(
          padding: EdgeInsets.only(top: 4.h),
          height: 100.h,
          width: 80.w,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "العروض",
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
                              return BlocBuilder<OffersBloc, OfferState>(
                                builder: (context, state) {
                                  var bloc =
                                      BlocProvider.of<OffersBloc>(context);
                                  return DialogForOffer(
                                    id: '0',
                                    bloc: bloc,
                                    isEdit: false,
                                  );
                                },
                              );
                            },
                          );
                        },
                        text: 'إضافة عرض جديد')
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              BlocBuilder<OffersBloc, OfferState>(
                builder: (context, state) {
                  OffersBloc bloc = BlocProvider.of<OffersBloc>(context);
                  return bloc.data.isEmpty
                      ? const EmptyScreen()
                      : SizedBox(
                          height: 84.h,
                          child: GridView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 2.5.w,
                                mainAxisSpacing: 2.h,
                                childAspectRatio: 1 / 0.6,
                              ),
                              itemCount: bloc.data.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 30.h,
                                  width: 30.w,
                                  child: Card(
                                    color: lightGrey,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 6,
                                                child: Container(
                                                  // height: 30.h,
                                                  width: 12.w,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.w),
                                                  color: AppColors.secondary,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Text(
                                                        bloc.data[index].title,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      Text(
                                                        bloc.data[index]
                                                            .description,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  // height: 3.5.h,
                                                  alignment: Alignment.center,
                                                  width: 12.w,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.w),
                                                  color: const Color.fromARGB(
                                                      255, 65, 71, 134),
                                                  child: Text(
                                                    "${formatDate(bloc.data[index].date.toString())} ${getArabicDayName(bloc.data[index].date.toString())}",
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                              Container(
                                                height: 38.h,
                                                color: lightGrey,
                                                child: CustomCacheImage(
                                                    imageUrl: bloc.data[index]
                                                                .image?.image !=
                                                            null
                                                        ? (AppLink
                                                                .imageBaseUrl +
                                                            bloc.data[index]
                                                                .image!.image)
                                                        : 'https://i.pinimg.com/originals/7b/0e/c8/7b0ec89096c618275645a084490d781c.jpg'),
                                              ),
                                              Container(
                                                height: 38.h,
                                                width: 12.w,
                                                color: Colors.black26,
                                              ),
                                              PositionedDirectional(
                                                end: 0.3.w,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (contextc) {
                                                            return CustomDialog(
                                                              color: Colors.red,
                                                              function:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                await bloc.deleteOffer(
                                                                    bloc
                                                                        .data[
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    context);
                                                              },
                                                              text:
                                                                  'تأكيد حذف العرض ؟',
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: const Icon(
                                                        Icons
                                                            .delete_outline_outlined,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        bloc.fillDataForEdit(
                                                            bloc.data[index]);
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return BlocBuilder<
                                                                OffersBloc,
                                                                OfferState>(
                                                              builder: (context,
                                                                  state) {
                                                                var bloc = BlocProvider
                                                                    .of<OffersBloc>(
                                                                        context);
                                                                return DialogForOffer(
                                                                    id: bloc
                                                                        .data[
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    isEdit:
                                                                        true,
                                                                    bloc: bloc);
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: const Icon(
                                                        Icons.edit_outlined,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }));
                },
              ),
            ],
          ),
        );
      }
      return MainLayoutScreen(
        pageContent: pageContent,
      );
    }));
  }
}

class DialogForOffer extends StatelessWidget {
  const DialogForOffer({
    super.key,
    required this.bloc,
    required this.isEdit,
    required this.id,
  });
  final bool isEdit;
  final OffersBloc bloc;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
          width: 40.w,
          height: bloc.isValid ? 50.h : 55.h,
          padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: OfferWidget(
            id: id,
            bloc: bloc,
            isEdit: isEdit,
          )),
    );
  }
}

class OfferWidget extends StatelessWidget {
  const OfferWidget({
    super.key,
    required this.bloc,
    required this.isEdit,
    this.id,
  });
  final bool isEdit;
  final String? id;
  final OffersBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersBloc, OfferState>(
      builder: (context, state) {
        OffersBloc bloc = BlocProvider.of<OffersBloc>(context);
        if (state is ErrorOfferState) {
          return MyErrorWidget(
            text: state.message,
          );
        } else if (state is LoadingOfferState) {
          return const LoadingWidget();
        } else {
          return Column(
            children: [
              Text(
                isEdit == true ? 'تعديل عرض' : 'إضافة عرض',
                style: const TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Form(
                key: bloc.formstate,
                child: Column(
                  children: [
                    SizedBox(
                      // color: Colors.cyan,
                      // height: 25.h,
                      width: 40.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 25.w,
                                  child: CustomTextFiledWithValidate(
                                      height: !bloc.isValid ? 60 : null,
                                      validator: (val) {
                                        return vaildator(val!, 3, 30, 'name');
                                      },
                                      hintText: 'اسم العرض',
                                      controller: bloc.title)),
                              SizedBox(
                                height: 4.h,
                              ),
                              SizedBox(
                                width: 25.w,
                                child: CustomTextFiledWithValidate(
                                    height: !bloc.isValid ? 60 : null,
                                    validator: (val) {
                                      return vaildator(val!, 15, 100, 'name');
                                    },
                                    hintText: 'الوصف',
                                    controller: bloc.description),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            width: 10.w,
                            child: PickImageWidget(bloc: bloc),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      height: 10.h,
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          myButton(
                              width: 6.w,
                              height: 6.h,
                              elevation: 0,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              backgroundColor: AppColors.primary,
                              onPressed: () {
                                if (isEdit) {
                                  bloc.editOffer(id.toString(), context);
                                } else {
                                  bloc.addOffer(context);
                                }
                              },
                              text: isEdit ? "تعديل" : 'إضافة'),
                          SizedBox(
                            width: 1.5.w,
                          ),
                          myButton(
                              width: 6.w,
                              height: 6.h,
                              elevation: 0,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              backgroundColor: whiteColor,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: 'إلغاء'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

void showToastForState(BuildContext context, OfferState state) {
  String message;
  String toastType;

  if (state is ErrorDeleteOfferState) {
    message = 'حدث خطأ أثناء حذف العرض , حاول مجدداً';
    toastType = "Error";
  } else if (state is SuccessDeleteOfferState) {
    message = 'تم حذف العرض بنجاح';
    toastType = "Success";
  } else if (state is ErrorAddOfferState) {
    message = 'حدث خطأ أثناء اضافة العرض , حاول مجدداً';
    toastType = "Error";
  } else if (state is SuccessAddOfferState) {
    message = 'تم اضافة العرض بنجاح';
    toastType = "Success";
  } else if (state is ErrorEditOfferState) {
    message = 'حدث خطأ أثناء تعديل العرض , حاول مجدداً';
    toastType = "Error";
  } else if (state is SuccessEditOfferState) {
    message = 'تم تعديل العرض بنجاح';
    toastType = "Success";
  } else {
    return; // No relevant state to handle
  }

  // Show the toast message
  CustomToast(type: toastType, msg: message)(context);
}
