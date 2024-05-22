import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/global-widgets/my_buttons.dart';
import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Obx(() => Stack(
            children: [
              PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.selectedPage.call,
                itemCount: controller.onBoardingPages.length,
                itemBuilder: (context, index) {
                  return controller.onBoardingPages.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                            color: theme.primaryColor,
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(height: 100.sp),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.sp),
                              child: SizedBox(
                                width: 300.w,
                                child: Text(
                                  controller.onBoardingPages[index].title,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    height: 1.4,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 40.sp),
                            Container(
                              height: 200.h,
                              width: 300.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(controller
                                    .onBoardingPages[index].imageAsset),
                                fit: BoxFit.cover,
                              )),
                            ),
                            SizedBox(height: 40.sp),
                            SizedBox(
                              width: 300.w,
                              child: Text(
                                controller.onBoardingPages[index].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: theme.hintColor,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        );
                },
              ),
              Positioned(
                bottom: 130.h,
                left: 160.w,
                child: Row(
                  children: List.generate(
                      controller.onBoardingPages.length,
                      (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            height: 4,
                            width: 20.sp,
                            decoration: BoxDecoration(
                              color: controller.selectedPage.value == index
                                  ? theme.primaryColor
                                  : theme.primaryColor.withOpacity(.2),
                              borderRadius: BorderRadius.circular(30.r),
                              shape: BoxShape.rectangle,
                            ),
                          )),
                ),
              ),
              Positioned(
                top: 40.sp,
                right: 0,
                child: SizedBox(
                  width: 80.sp,
                  height: 40.sp,
                  child: TextButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.FLOATING_NAV);
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 40.sp,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      controller.selectedPage.value > 0
                          ? SizedBox(
                              width: 80.sp,
                              height: 40.sp,
                              child: PrimaryButton(
                                title: 'Prev',
                                onPressed: () {
                                  controller.backwardAction();
                                },
                                inactive: false,
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: 80.sp,
                        height: 40.sp,
                        child: PrimaryButton(
                          title: controller.selectedPage.value >
                                  controller.onBoardingPages.length - 2
                              ? "Go!"
                              : "Next",
                          onPressed: () {
                            if (controller.selectedPage.value >
                                controller.onBoardingPages.length - 2) {
                              Get.offAllNamed(Routes.FLOATING_NAV);
                            } else {
                              controller.forwardAction();
                            }
                          },
                          inactive: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
