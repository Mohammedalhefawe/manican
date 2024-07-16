import 'package:flutter/material.dart';
import 'package:manican/core/theme/app_colors.dart';
import 'package:manican/core/theme/app_theme.dart';
import 'package:manican/features/offers/presentation/bloc/add_offer_bloc/add_offer_bloc.dart';
import 'package:sizer/sizer.dart';

class AddImageWidget extends StatelessWidget {
  const AddImageWidget({
    super.key,
    required this.bloc,
  });

  final AddOfferBloc bloc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bloc.addImage();
      },
      child: Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          height: 33.h,
          width: 10.w,
          color: const Color.fromARGB(255, 234, 235, 238),
          child: Column(
            children: [
              Text(
                'Picture',
                style: appTheme.textTheme.titleLarge!.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: 4.h,
              ),
              Container(
                height: 8.h,
                width: 3.5.w,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4)),
                child: const Icon(
                  Icons.add,
                  size: 45,
                  color: Color.fromARGB(255, 234, 235, 238),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
