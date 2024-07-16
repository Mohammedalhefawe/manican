//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manican/core/constance/appImgaeAsset.dart';

class CustomCacheImage extends StatelessWidget {
  final String imageUrl;
  const CustomCacheImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImageAsset.backgroundProfile);
  }
}


/*CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: imageUrl,
      placeholder: (context, url) => const Text(''),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ); */