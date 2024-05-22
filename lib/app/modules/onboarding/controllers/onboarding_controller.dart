import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../model/on_boarding_model.dart';

class OnboardingController extends GetxController {
  RxInt selectedPage = 0.obs;
  final pageController = PageController();
  final autoScrollDuration =
      const Duration(seconds: 4); // Adjust the duration as needed
  Timer? autoScrollTimer;

  /// Next
  forwardAction() {
    pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  /// Previous
  backwardAction() {
    pageController.previousPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  /// Auto scroll
  void startAutoScroll() {
    autoScrollTimer = Timer.periodic(autoScrollDuration, (timer) {
      if (selectedPage.value < onBoardingPages.length - 1) {
        selectedPage.value++;
        pageController.animateToPage(
          selectedPage.value,
          duration: 300.milliseconds,
          curve: Curves.ease,
        );
      } else {
        autoScrollTimer?.cancel();
      }
    });
  }

  /// List of Page
  List<OnBoardingModel> onBoardingPages = [
    OnBoardingModel(
        imageAsset: Onboarding.kBoard1,
        title: 'Flutter and GetX: Empowering Efficient Development.',
        description:
            'GetX: A concise Flutter library for efficient state management and navigation, enhancing app development.'),
    OnBoardingModel(
        imageAsset: Onboarding.kBoard2,
        title:
            'Flutter supports both REST and GraphQL for handling API requests in your applications.',
        description:
            'Get Strong and smart client and error handling for both REST and GraphQL in GetX.'),
  ];
  @override
  void onInit() {
    super.onInit();
    startAutoScroll();
  }

  @override
  void onClose() {
    autoScrollTimer?.cancel();
    super.onClose();
  }
}
