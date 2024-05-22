import 'package:get/get.dart';
import 'package:movie_catalog_app/app/components/navbar/fixed_bottom_navbar.dart';

import '../components/navbar/floating_bottom_navbar.dart';
import '../components/navbar/navbar_binding.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/movie_detail_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const ONBOARDING = Routes.ONBOARDING;
  static const FIXED_NAV = Routes.FIXED_NAV;
  static const FLOATING_NAV = Routes.FLOATING_NAV;
  static const HOME = Routes.HOME;
  static const MOVIE_DETAIL = Routes.MOVIE_DETAIL;

  static final routes = [
    /// NAV BARs
    GetPage(
      name: _Paths.FIXED_NAV,
      page: () => const FixedBottomNavbar(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.FLOATING_NAV,
      page: () => const FloatingBottomNavbar(),
      binding: NavbarBinding(),
    ),

    ///
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE_DETAIL,
      page: () => const MovieDetailView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
  ];
}
