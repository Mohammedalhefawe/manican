import 'package:flutter/material.dart';
import 'package:manicann/core/components/custom_cache_image.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/branches/data/models/branch_model.dart';
import 'package:sizer/sizer.dart';

class BranchWidget extends StatelessWidget {
  final BranchModel branchModel;
  final int index;
  final bool? selected;
  final void Function()? onTap;
  final void Function()? onDoubleTap;

  const BranchWidget({
    super.key,
    required this.branchModel,
    required this.index,
    this.selected,
    this.onTap,
    this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: selected == true
              ? const Color(0xff414786)
              : const Color(0xffEAEBEE),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 1.3.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 300,
                height: 100,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CustomCacheImage(
                    imageUrl: branchModel.image?.image != null
                        ? (AppLink.imageBaseUrl + branchModel.image!.image)
                        : 'https://i.pinimg.com/originals/7b/0e/c8/7b0ec89096c618275645a084490d781c.jpg'),
              ),
            ),
            SizedBox(height: 1.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "فرع ${branchModel.name ?? index + 1}",
                    style: TextStyle(
                      fontFamily: "Cairo",
                      color:
                          selected == true ? AppColors.primary : Colors.black,
                      fontSize: 3.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    "${branchModel.description} ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Cairo",
                      color: const Color(0xff9EA2B0),
                      fontSize: 2.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    "الموقع الجغرافي",
                    style: TextStyle(
                      fontFamily: "Cairo",
                      color:
                          selected == true ? AppColors.primary : Colors.black,
                      fontSize: 3.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    branchModel.location,
                    style: TextStyle(
                      fontFamily: "Cairo",
                      color: const Color(0xff9EA2B0),
                      fontSize: 2.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "أيام الدوام",
                    style: TextStyle(
                      fontFamily: "Cairo",
                      color:
                          selected == true ? AppColors.primary : Colors.black,
                      fontSize: 3.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  SizedBox(
                    width: 20.w,
                    // height: 4.h,
                    child: Text(
                      branchModel.workingDays.join(' , '),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontFamily: "Cairo",
                        color: Color(0xff9EA2B0),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // SizedBox(height: 1.h),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     const Icon(
                  //       Icons.people_alt_outlined,
                  //       color: Color(0xff9EA2B0),
                  //       size: 20,
                  //     ),
                  //     SizedBox(
                  //       width: 1.w,
                  //     ),
                  //     Text(
                  //       "${'numOfClients' ?? 200} Clients",
                  //       style: TextStyle(
                  //         fontFamily: "Cairo",
                  //         color: const Color(0xff9EA2B0),
                  //         fontSize: 2.5.sp,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
