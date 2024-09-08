// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:manicann/core/constance/appImgaeAsset.dart';
// import 'package:manicann/core/theme/app_colors.dart';
// import 'package:sizer/sizer.dart';

// class CustomCarouselSlider extends StatelessWidget {
//   final CarouselController? carouselController;
//   final List<String> images;
//   final int initpage;
//   final void Function()? onPressedPrevious;
//   final void Function()? onPressedNext;
//   const CustomCarouselSlider(
//       {super.key,
//       this.carouselController,
//       required this.images,
//       required this.initpage,
//       this.onPressedPrevious,
//       this.onPressedNext});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         initpage > 0
//             ? ArrowIconButton(
//                 onPressed: onPressedPrevious,
//                 icon: Icons.arrow_left_rounded,
//               )
//             : SizedBox(
//                 width: 15.w,
//               ),
//         ContentCarouselSlider(
//             carouselController: carouselController,
//             images: images,
//             initpage: initpage),
//         initpage < images.length - 1
//             ? ArrowIconButton(
//                 onPressed: onPressedNext,
//                 icon: Icons.arrow_right_rounded,
//               )
//             : SizedBox(
//                 width: 15.w,
//               ),
//       ],
//     );
//   }
// }

// class ContentCarouselSlider extends StatelessWidget {
//   const ContentCarouselSlider({
//     super.key,
//     required this.carouselController,
//     required this.images,
//     required this.initpage,
//     this.dateOffer,
//     this.title,
//     this.description,
//   });

//   final CarouselController? carouselController;
//   final List<String> images;
//   final int initpage;
//   final String? dateOffer;
//   final String? title;
//   final String? description;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 38.h,
//       width: 30.w,
//       child: CarouselSlider(
//           carouselController: carouselController,
//           items: List.generate(
//             images.length,
//             (index) => SizedBox(
//               height: 38.h,
//               width: 30.w,
//               child: Card(
//                 color: Colors.white,
//                 clipBehavior: Clip.antiAliasWithSaveLayer,
//                 child: Row(
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           height: 34.5.h - 8,
//                           width: 18.w,
//                           padding: EdgeInsets.symmetric(horizontal: 1.w),
//                           color: AppColors.secondary,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 2.h,
//                               ),
//                               Text(
//                                 title ?? "Botox Offer",
//                                 style: const TextStyle(
//                                     fontSize: 33, color: Colors.white),
//                               ),
//                               SizedBox(
//                                 height: 2.h,
//                               ),
//                               Text(
//                                 description ??
//                                     "Discounts on Botox up to 50% ...Starts on Monday 25/5/2024 and continues until Saturday 5/30/2024",
//                                 maxLines: 4,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 14, color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: 3.5.h,
//                           width: 18.w,
//                           padding: EdgeInsets.symmetric(horizontal: 1.w),
//                           color: const Color.fromARGB(255, 65, 71, 134),
//                           child: Text(
//                             dateOffer ?? "Saturday 24/5/2024",
//                             style: const TextStyle(
//                                 fontSize: 14, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       height: 38.h,
//                       width: 12.w - 8,
//                       color: Colors.black26,
//                       child: Image.asset(
//                         AppImageAsset.backgroundProfile,
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           options: CarouselOptions(
//             aspectRatio: 1,
//             initialPage: initpage,
//             autoPlayAnimationDuration: const Duration(milliseconds: 500),
//             enableInfiniteScroll: false,
//             viewportFraction: 1,
//           )),
//     );
//   }
// }

// class ArrowIconButton extends StatelessWidget {
//   final IconData icon;
//   final void Function()? onPressed;
//   const ArrowIconButton({
//     super.key,
//     required this.onPressed,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 15.w,
//       child: IconButton(
//           onPressed: onPressed,
//           hoverColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//           icon: Icon(
//             icon,
//             color: AppColors.primary,
//             size: 30.sp,
//           )),
//     );
//   }
// }
