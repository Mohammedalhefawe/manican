


import 'package:flutter/material.dart';
import 'package:manican/core/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class BeforeAfterScreen extends StatelessWidget {
  const BeforeAfterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 80.w,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Offers",
                // style: GoogleFonts.glegoo(
                //   fontSize: 32,
                //   fontWeight: FontWeight.w700,
                // ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BeforeAfterImageWidget(
                          text: 'Before',
                          onAddImage: () {},
                        ),
                        const Icon(Icons.arrow_forward_outlined),
                        BeforeAfterImageWidget(
                          text: 'After',
                          onAddImage: () {},
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




class BeforeAfterImageWidget extends StatelessWidget {
  final String text;
  final void Function()? onAddImage;
  const BeforeAfterImageWidget({
    super.key,
    required this.text,
    this.onAddImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 17.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text),
              const Icon(
                Icons.one_x_mobiledata,
              ),
              Icon(
                Icons.add,
                color: AppColors.primary,
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          InkWell(
            onTap: onAddImage,
            child: SizedBox(
              height: 28.h,
              width: 17.w,
              child: Card(
                color: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Center(
                    child: Icon(
                  Icons.image_outlined,
                  size: 40,
                  color: Colors.grey.shade400,
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}