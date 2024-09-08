import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class MyErrorWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyErrorWidget({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: appTheme.textTheme.titleLarge!.copyWith(color: Colors.black45),
        ),
        SizedBox(
          height: 4.h,
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'حاول مرة أخرى ....',
                textAlign: TextAlign.center,
                style: appTheme.textTheme.titleLarge!
                    .copyWith(color: Colors.black45),
              ),
              SizedBox(
                width: 1.w,
              ),
              const Icon(Icons.refresh, color: Colors.black45)
            ],
          ),
        )
      ],
    );
  }
}
