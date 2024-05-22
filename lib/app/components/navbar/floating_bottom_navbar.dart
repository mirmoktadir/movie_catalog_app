// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import 'navbar_controller.dart';

class FloatingBottomNavbar extends GetView<NavbarController> {
  const FloatingBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Obx(() => controller.navigation[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => Stack(
            children: [
              Positioned(
                bottom: 35.h,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                          color: theme.colorScheme.secondary.withOpacity(1),
                          spreadRadius: 0,
                          blurRadius: 10.r),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 65.w),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 75.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /// ITEM 1
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: IconButton(
                                hoverColor: Colors.transparent,
                                onPressed: () {
                                  controller.onTap(0);
                                },
                                icon: Icon(
                                  controller.selectedIndex.value == 0
                                      ? IconlyBold.home
                                      : IconlyLight.home,
                                  color: Colors.white,
                                  size: 25.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.sp),
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.selectedIndex.value == 0
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),

                        /// ITEM 2
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: IconButton(
                                hoverColor: Colors.transparent,
                                onPressed: () {
                                  controller.onTap(1);
                                },
                                icon: Icon(
                                  controller.selectedIndex.value == 1
                                      ? IconlyBold.graph
                                      : IconlyLight.graph,
                                  color: Colors.white,
                                  size: 25.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.sp),
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.selectedIndex.value == 1
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
