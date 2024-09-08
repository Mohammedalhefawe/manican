import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/custom_cache_image.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/app_theme.dart';
import 'package:manicann/features/services/domain/entities/service.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_cubit.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_state.dart';
import 'package:sizer/sizer.dart';

class SelectServicesScreen extends StatelessWidget {
  const SelectServicesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ServiceBloc, ServiceState>(builder: (context, state) {
      ServiceBloc bloc = BlocProvider.of<ServiceBloc>(context);
      if (state is ErrorServiceState) {
        return MyErrorWidget(
          text: state.message,
          onTap: () {
            bloc.getAllServices();
          },
        );
      } else if (state is LoadingServiceState) {
        return const LoadingWidget();
      } else {
        return Container(
          height: 100.h,
          width: 80.w,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "اختر الخدمة",
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  height: 80.h,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 3.5.w,
                      mainAxisSpacing: 1.h,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      return ShowService(
                          showDetailsService: () {},
                          serviceData: bloc.data[index]);
                    },
                    itemCount: bloc.data.length,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }));
  }
}

class ShowService extends StatelessWidget {
  const ShowService({
    super.key,
    required this.showDetailsService,
    required this.serviceData,
  });

  final void Function()? showDetailsService;
  final ServiceEntity serviceData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: showDetailsService,
          child: SizedBox(
            height: 21.h,
            width: 11.w,
            child: Card(
              color: AppColors.secondary,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CustomCacheImage(
                  imageUrl: serviceData.image?.image != null
                      ? (AppLink.imageBaseUrl + serviceData.image!.image)
                      : 'https://i.pinimg.com/originals/7b/0e/c8/7b0ec89096c618275645a084490d781c.jpg'),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 2.h),
          height: 5.h,
          child: Text(
            serviceData.name,
            textAlign: TextAlign.center,
            style: appTheme.textTheme.titleLarge,
          ),
        )
      ],
    );
  }
}
