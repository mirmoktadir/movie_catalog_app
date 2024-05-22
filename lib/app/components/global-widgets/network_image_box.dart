import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants.dart';

class NetworkImageBox extends StatelessWidget {
  const NetworkImageBox({
    super.key,
    required this.url,
    required this.radius,
  });

  final String url;
  final num radius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 110.sp,
      width: 110.sp,
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(radius.r),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Lottie.asset(
        'animations/image_loader.json',
        height: 120.sp,
        repeat: true,
        reverse: true,
        fit: BoxFit.cover,
      ),
      errorWidget: (context, url, error) => Container(
        height: 300.sp,
        width: 300.sp,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffF3F3F3),
          border: Border.all(color: Colors.white, width: 1),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          AppImages.kNoImage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
