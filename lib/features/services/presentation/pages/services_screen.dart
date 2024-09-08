import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_cache_image.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/shared_screen/no_data_screen.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/app_theme.dart';
import 'package:manicann/features/services/domain/entities/service.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_cubit.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_state.dart';
import 'package:manicann/features/services/presentation/widgets/dialog_add_discount.dart';
import 'package:manicann/features/services/presentation/widgets/dialog_add_service.dart';
import 'package:manicann/shared_screen/main_layout_screen.dart';
import 'package:sizer/sizer.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, state) {
        ServiceBloc bloc = BlocProvider.of<ServiceBloc>(context);
        Widget pageContent;
        if (state is ErrorServiceState) {
          pageContent = MyErrorWidget(
            text: state.message,
            onTap: () {
              bloc.getAllServices();
            },
          );
        } else if (state is LoadingServiceState) {
          pageContent = const LoadingWidget();
        } else {
          pageContent = SizedBox(
            height: 100.h,
            width: 80.w,
            // color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "الخدمات",
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
                                  return AddDiscountDialog(
                                    bloc: bloc,
                                    controllerDiscount: bloc.controllerDiscount,
                                    onAdd: () {
                                      bloc.serviceIds = [];
                                      for (var i = 0;
                                          i < bloc.data.length;
                                          i++) {
                                        bloc.serviceIds.add(bloc.data[i].id);
                                      }
                                      bloc.addDiscount(context);
                                    },
                                  );
                                });
                          },
                          text: 'إضافة خصم على جميع الخدمات')
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                    height: 80.h,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 2.5.w,
                        mainAxisSpacing: 1.h,
                        childAspectRatio: 35.h / 23.w,
                      ),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return AddNewService(addService: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AddServiceDialog(
                                  bloc: bloc,
                                  controllerNameService:
                                      bloc.controllerNameService,
                                  controllerPerioud: bloc.controllerPerioud,
                                  controllerPrice: bloc.controllerPrice,
                                  pickImage: () {
                                    bloc.pickImage();
                                  },
                                  onAdd: () {
                                    bloc.addService(context);
                                  },
                                );
                              },
                            );
                          });
                        } else {
                          return ShowService(
                            showDetailsService: () {
                              //
                            },
                            serviceData: bloc.data[index - 1],
                            onAddSpecialist: () {
                              bloc.addSpecialist(context);
                            },
                            onAddDisconut: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AddDiscountDialog(
                                      bloc: bloc,
                                      controllerDiscount:
                                          bloc.controllerDiscount,
                                      onAdd: () {
                                        bloc.serviceIds = [];
                                        bloc.serviceIds
                                            .add(bloc.data[index - 1].id);
                                        bloc.addDiscount(context);
                                      },
                                    );
                                  });
                            },
                          );
                        }
                      },
                      itemCount: bloc.data.length + 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return MainLayoutScreen(
          pageContent: pageContent,
        );
      },
    ));
  }
}

class ShowService extends StatelessWidget {
  const ShowService({
    super.key,
    required this.showDetailsService,
    required this.serviceData,
    required this.onAddSpecialist,
    required this.onAddDisconut,
  });

  final void Function()? showDetailsService;
  final void Function() onAddSpecialist;
  final void Function() onAddDisconut;
  final ServiceEntity serviceData;

  @override
  Widget build(BuildContext context) {
    double price =
        (((serviceData.price - serviceData.newPrice) / serviceData.price) * 100)
            .round() as double;
    return Column(
      children: [
        InkWell(
          onTap: showDetailsService,
          child: SizedBox(
            height: 35.h,
            width: 20.w,
            child: Card(
                color: lightGrey,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 18.h,
                              width: 20.w,
                              child: CustomCacheImage(
                                  imageUrl: serviceData.image?.image != null
                                      ? (AppLink.imageBaseUrl +
                                          serviceData.image!.image)
                                      : 'https://i.pinimg.com/originals/7b/0e/c8/7b0ec89096c618275645a084490d781c.jpg'),
                            ),
                            Container(
                              height: 18.h,
                              width: 20.w,
                              color: Colors.black12,
                            ),
                            SizedBox(
                              width: 10.w,
                              child: Text(
                                serviceData.name,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontFamily: "Cairo",
                                    color: Colors.amber,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        serviceData.newPrice != 0
                            ? PositionedDirectional(
                                top: 1.5.h,
                                end: -3.2.w,
                                child: DiscountBadge(
                                  discountText: 'خصم %$price',
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                      width: 11.w,
                      child: InfoService(
                        period: serviceData.period.toString(),
                        newPrice: serviceData.newPrice.round().toString(),
                        price: serviceData.price.round().toString(),
                        onAddSpecialist: onAddSpecialist,
                        onAddDisconut: onAddDisconut,
                      ),
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }
}

class AddNewService extends StatelessWidget {
  const AddNewService({
    super.key,
    required this.addService,
  });

  final void Function()? addService;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: addService,
          child: SizedBox(
            height: 35.h,
            width: 20.w,
            child: Card(
              color: lightGrey,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "+ إضافة خدمة جديدة",
                    textAlign: TextAlign.center,
                    style: appTheme.textTheme.titleLarge,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoService extends StatelessWidget {
  final String newPrice;
  final String price;
  final String period;
  final void Function() onAddSpecialist;
  final void Function() onAddDisconut;
  const InfoService(
      {super.key,
      required this.newPrice,
      required this.price,
      required this.onAddSpecialist,
      required this.onAddDisconut,
      required this.period});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 1.h),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 4.w,
                child: const Text(
                  'التكلفة :',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: 6.w,
                child: Text(
                  '$price ل س',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      // decoration: newPrice == '0'
                      //     ? TextDecoration.none
                      //     : TextDecoration.lineThrough,
                      fontFamily: "Cairo",
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 4.w,
                    child: const Text(
                      'الفترة : ',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                    child: Text(
                      '$period دقيقة',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              myButton(
                  height: 3.8.h,
                  borderRadius: 8,
                  borderColor: Colors.transparent,
                  backgroundColor: Colors.grey.shade400,
                  text: 'إضافة خصم',
                  onPressed: onAddDisconut)
            ],
          ),
        ],
      ),
    );
  }
}

class CustomInkwell extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CustomInkwell({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary.withOpacity(0.6),
            size: 15,
          ),
          SizedBox(
            width: 1.w,
          ),
          Text(
            label,
            style: const TextStyle(
              fontFamily: "Cairo",
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}

class DiscountBadge extends StatelessWidget {
  final String discountText;

  const DiscountBadge({super.key, required this.discountText});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -35 * 3.141592653589793238 / 180,
      child: Container(
        height: 3.h,
        width: 10.w,
        color: Colors.red,
        alignment: Alignment.center,
        child: Text(
          discountText,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
