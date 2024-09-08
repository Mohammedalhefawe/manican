//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_colors.dart';

class CustomCacheImage extends StatelessWidget {
  final String imageUrl;
  final bool? smallIcon;
  const CustomCacheImage({super.key, required this.imageUrl, this.smallIcon});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: imageUrl,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: AppColors.primary,
          strokeWidth: 0.9,
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey,
        grade: 3,
        size: smallIcon == true ? 20 : 40,
      ),
    );
  }
}


/*Align(
          alignment: Alignment.center,
          child: SizedBox(width: 3.w, child: const LoadingWidget()))*/