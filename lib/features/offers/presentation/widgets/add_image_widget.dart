import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/app_theme.dart';
import 'package:manicann/features/offers/presentation/bloc/offer_bloc/offer_bloc.dart';
import 'package:sizer/sizer.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({
    super.key,
    required this.bloc,
  });

  final OffersBloc bloc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bloc.pickImage();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: bloc.selecetImage == false ? 4.h : 0),
        height: 25.h,
        width: 10.w,
        color: const Color.fromARGB(255, 234, 235, 238),
        child: bloc.selecetImage == true
            ? Image.memory(
                bloc.webImage,
                fit: BoxFit.cover,
                height: 25.h,
                width: 10.w,
              )
            : Column(
                children: [
                  Text(
                    'أختيار صورة',
                    style:
                        appTheme.textTheme.titleLarge!.copyWith(fontSize: 16),
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
    );
  }
}
