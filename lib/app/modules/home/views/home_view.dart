import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_catalog_app/app/components/global-widgets/splash_container.dart';
import 'package:movie_catalog_app/app/routes/app_pages.dart';
import 'package:movie_catalog_app/app/service/REST/api_urls.dart';
import 'package:movie_catalog_app/app/service/helper/network_connectivity.dart';
import 'package:movie_catalog_app/config/theme/light_theme_colors.dart';
import 'package:iconsax/iconsax.dart';

import '../../../components/global-widgets/empty_widget.dart';
import '../../../components/global-widgets/my_snackbar.dart';
import '../../../components/global-widgets/network_image_box.dart';
import '../../../data/local/my_shared_pref.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    //
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Obx(
          () => controller.isError.value == true
              ? EmptyWidget(
                  onPressed: () async => await controller.getAllMovies())
              : RefreshIndicator(
                  color: theme.primaryColor,
                  onRefresh: () async => await controller.getAllMovies(),
                  child: SafeArea(
                    child: Column(
                      children: [
                        _header(theme),
                        _movies(theme),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Container _header(ThemeData theme) {
    return Container(
      margin: EdgeInsets.all(18.sp),
      height: 160.sp,
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 50.sp),
            child: Text(
              "Find Movies, TV series, and more...",
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 25.sp),
          TextFormField(
            controller: controller.searchEditingController,
            obscureText: false,
            onSaved: (value) {
              controller.searchEditingController.text = value!;
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            cursorColor: LightThemeColors.primaryColor,
            onFieldSubmitted: (v) async {
              await controller.search(v);
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Iconsax.search_favorite,
                color: Colors.grey,
                size: 20.sp,
              ),
              filled: true,
              fillColor: theme.primaryColor,
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _movies(ThemeData theme) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.sp, 0.sp, 18.sp, 18.sp),
        child: GridView.builder(
          itemCount: controller.movies.length,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          controller: controller.scrollController,
          itemBuilder: (context, index) => Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SplashContainer(
                      radius: 15,
                      onPressed: () {},
                      child: Container(
                        width: 150.sp,
                        height: 170.sp,
                        padding:
                            EdgeInsets.fromLTRB(10.sp, 46.sp, 10.sp, 12.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: MySharedPref.getThemeIsLight()
                              ? Colors.white
                              : Colors.orange.withOpacity(.1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0, end: 1),
                              duration: const Duration(milliseconds: 2500),
                              builder: (BuildContext context, double value,
                                  Widget? child) {
                                return Opacity(
                                  opacity: value,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: value * 60.r),
                                    child: child,
                                  ),
                                );
                              },
                              child: Text(
                                controller.movies[index].title ?? "",
                                style: theme.textTheme.titleLarge,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1500),
                builder: (BuildContext context, double value, Widget? child) {
                  return Opacity(
                    opacity: value,
                    child: Padding(
                      padding: EdgeInsets.only(top: value * 30.r),
                      child: child,
                    ),
                  );
                },
                child: SizedBox(
                  height: 150.sp,
                  width: 130.sp,
                  child: NetworkImageBox(
                    url:
                        "${ApiUrl.image}${controller.movies[index].posterPath}",
                    radius: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (await NetworkConnectivity.isNetworkAvailable()) {
                    await controller
                        .getMovieDetail(controller.movies[index].id.toString());

                    await 1.delay();
                    Get.toNamed(Routes.MOVIE_DETAIL);
                  } else {
                    MySnackBar.showErrorToast(message: "No network!");
                  }
                },
                child: Container(
                  height: 240.sp,
                  width: 150.sp,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
          ),
        ),
      ),
    );
  }
}
