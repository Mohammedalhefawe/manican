import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manican/core/theme/app_colors.dart';
import 'package:manican/core/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class ServicesScreen extends StatelessWidget {
  final void Function()? addService;
  final void Function()? showDetailsService;
  final List servicesData;

  const ServicesScreen(
      {super.key,
      this.addService,
      required this.servicesData,
      this.showDetailsService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Container(
          height: 100.h,
          width: 20.w,
          color: Colors.grey,
        ),
        Container(
          height: 100.h,
          width: 80.w,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Services",
                  style: GoogleFonts.glegoo(
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
                      if (index == 0) {
                        return AddNewService(addService: addService);
                      } else {
                        return ShowService(
                            showDetailsService: showDetailsService,
                            servicesData: servicesData[index-1]);
                      }
                    },
                    itemCount: servicesData.length + 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class ShowService extends StatelessWidget {
  const ShowService({
    super.key,
    required this.showDetailsService,
    required this.servicesData,
  });

  final void Function()? showDetailsService;
  final servicesData;

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
                child: Image.network(
                  'https://thumbs.dreamstime.com/b/doctor-office-clinic-room-illustration-vector-62032362.jpg',
                  fit: BoxFit.cover,
                )),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 2.h),
          height: 5.h,
          child: Text(
            "${servicesData}",
            style: appTheme.textTheme.titleLarge,
          ),
        )
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
            height: 21.h,
            width: 11.w,
            child: Card(
              color: AppColors.secondary,
              child: Center(
                  child: Text(
                "+ Add New Service",
                style: appTheme.textTheme.titleLarge,
              )),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 2.h),
          height: 5.h,
          child: const SizedBox(),
        )
      ],
    );
  }
}
