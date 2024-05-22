import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_catalog_app/config/translations/strings_enum.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'animations/error.json',
          height: 120.h,
          repeat: true,
          reverse: true,
          fit: BoxFit.cover,
        ),
        Center(
          child: Text(
            Strings.empty.tr,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: theme.hintColor.withOpacity(.5),
            ),
          ),
        ),
        SizedBox(height: 50.h),
        SizedBox(
          height: 44.h,
          child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade50,
                elevation: .5,
                shadowColor: theme.hintColor,
                padding: EdgeInsets.zero,
              ),
              child: Icon(
                Ionicons.refresh,
                size: 24,
                color: theme.primaryColor.withOpacity(.7),
              )),
        ),
        const SizedBox(height: 5),
        Text(
          Strings.refresh.tr,
          style: TextStyle(
            color: theme.hintColor.withOpacity(.5),
          ),
        ),
      ],
    );
  }
}
