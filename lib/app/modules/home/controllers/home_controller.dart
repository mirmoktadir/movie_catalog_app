import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/global-widgets/my_snackbar.dart';
import '../../../components/navbar/navbar_controller.dart';
import '../../../data/local/hive/my_hive.dart';
import '../../../service/REST/api_urls.dart';
import '../../../service/REST/dio_client.dart';
import '../../../service/handler/exception_handler.dart';
import '../../../service/helper/network_connectivity.dart';
import '../model/all_movies_model.dart';
import '../model/movie_detail_model.dart';
import '../model/related_movies_model.dart';

class HomeController extends GetxController with ExceptionHandler {
  final navController = Get.put(NavbarController());
  final scrollController = ScrollController();
  final TextEditingController searchEditingController = TextEditingController();

  RxDouble bottomPadding = 18.sp.obs;

  RxString title = "".obs;
  RxString body = "".obs;
  RxBool noSearch = false.obs;

  scrollPositionTracker() {
    Timer? debounce;

    scrollController.addListener(() {
      if (debounce != null && debounce!.isActive) {
        debounce!.cancel();
      }

      debounce = Timer(const Duration(milliseconds: 200), () {
        if (scrollController.position.pixels >
            scrollController.position.minScrollExtent + 5) {
          bottomPadding.value = 18.sp;
          // position in Top
        }
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent) {
          bottomPadding.value = 130.sp;
          // position in Bottom
        }
      });
    });
  }

  /// GET ALL MOVIES LIST 'HIVE IMPLEMENTED'
  final movies = RxList<Movies>();
  getAllMovies() async {
    showLoading();
    if (await NetworkConnectivity.isNetworkAvailable()) {
      /// Fetch recipes from the API
      var response = await DioClient()
          .get(
            url: ApiUrl.allMovies,
          )
          .catchError(handleError);

      if (response == null) return;

      movies.assignAll((response["results"] as List)
          .map((e) => Movies.fromJson(e))
          .toList());

      /// Save fetched posts to Hive for future use
      await MyHive.saveAllMovies(movies);
      hideLoading();
    } else {
      /// If offline, try to load from Hive
      var savedMovies = MyHive.getAllMovies();

      if (savedMovies.isNotEmpty) {
        movies.assignAll(savedMovies);
        hideLoading();
        MySnackBar.showErrorToast(message: "No network!");
        NetworkConnectivity.connectionChangeCount = 1;
        return;
      } else {
        isError.value = true;
        NetworkConnectivity.connectionChangeCount = 1;
        hideLoading();
        showErrorDialog("Oops!", "Connection problem");

        return;
      }
    }
  }

  MovieDetail? movieDetail;
  getMovieDetail(String movieID) async {
    showLoading();

    var response = await DioClient()
        .get(
          url: "${ApiUrl.movieDetails}$movieID",
        )
        .catchError(handleError);
    if (response == null) return;

    movieDetail = MovieDetail.fromJson(response);
    hideLoading();
    await getSimilarMovie(movieID);
  }

  final similarMovies = RxList<Similar>();
  getSimilarMovie(String movieID) async {
    var response = await DioClient()
        .get(
          url: "${ApiUrl.similarMovies}$movieID/similar",
        )
        .catchError(handleError);
    if (response == null) return;

    similarMovies.assignAll(
        (response["results"] as List).map((e) => Similar.fromJson(e)).toList());
  }

  search(String query) async {
    showLoading();

    var response = await DioClient().get(
      url: ApiUrl.search,
      params: {"query": query},
    ).catchError(handleError);
    if (response == null) return;

    movies.assignAll(
        (response["results"] as List).map((e) => Movies.fromJson(e)).toList());
    if (movies.isEmpty) {
      noSearch.value = true;
    }

    hideLoading();
  }

  @override
  void onReady() async {
    await getAllMovies();
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    scrollPositionTracker();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
