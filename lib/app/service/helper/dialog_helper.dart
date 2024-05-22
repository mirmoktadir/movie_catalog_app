import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../config/theme/light_theme_colors.dart';
import '../../../config/translations/strings_enum.dart';
import '../../../utils/constants.dart';

class DialogHelper {
  static get context => null;

  ///show error dialog
  static void showErrorDialog(String title, String description) {
    Get.dialog(
      Dialog(
        elevation: 6,
        shadowColor: LightThemeColors.primaryColor.withOpacity(.5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'animations/apiError.json',
                height: 120.sp,
                repeat: true,
                reverse: true,
                fit: BoxFit.cover,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 20.sp),
              AnimatedTextKit(repeatForever: true, animatedTexts: [
                ColorizeAnimatedText(description,
                    textStyle: Get.textTheme.headlineSmall as TextStyle,
                    textAlign: TextAlign.center,
                    colors: [
                      Colors.red,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ]),
              ]),
              SizedBox(height: 30.sp),
              SizedBox(
                width: 100.sp,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    if (Get.isDialogOpen!) Get.back();
                  },
                  child: Text(Strings.okay.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///show loading
  static Future<void> showLoading() async {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
      Get.dialog(
        Center(
          child: Container(
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // App Icon
                Container(
                  height: 50.sp,
                  width: 50.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.kAppIcon,
                      ),
                    ),
                  ),
                ),
                // Loader
                SizedBox(
                  height: 60.sp,
                  width: 60.sp,
                  child: const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(.1),
      );
    } else {
      Get.dialog(
        Center(
          child: Container(
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // App Icon
                Container(
                  height: 50.sp,
                  width: 50.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.kAppIcon,
                      ),
                    ),
                  ),
                ),
                // Loader
                SizedBox(
                  height: 60.sp,
                  width: 60.sp,
                  child: const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(.1),
      );
    }
  }

  ///hide loading
  static Future<void> hideLoading() async {
    if (Get.isDialogOpen!) {
      if (Get.isSnackbarOpen) {
        await SnackBarDurations.kMySnackBarDuration.delay();
        Get.closeAllSnackbars();
        Get.back();
      } else {
        Get.back();
      }
    }
  }
}
