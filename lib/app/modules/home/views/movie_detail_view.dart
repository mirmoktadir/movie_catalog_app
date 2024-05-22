import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_catalog_app/app/components/global-widgets/network_image_box.dart';

import '../../../service/REST/api_urls.dart';
import '../controllers/home_controller.dart';

class MovieDetailView extends GetView<HomeController> {
  const MovieDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var movie = controller.movieDetail;
    var similarMovie = controller.similarMovies;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(movie?.title ?? ""),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 18.sp),
          SizedBox(
            width: double.infinity,
            height: 250.sp,
            child: NetworkImageBox(
                url: "${ApiUrl.image}${movie?.posterPath}", radius: 0),
          ),
          Padding(
            padding: EdgeInsets.all(18.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie?.title ?? "",
                  style: theme.textTheme.headlineLarge,
                ),
                SizedBox(height: 12.sp),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      IconlyLight.time_circle,
                      color: Colors.white,
                    ),
                    SizedBox(width: 12.sp),
                    Text(
                      "${movie!.runtime.toString()} minutes",
                      style: theme.textTheme.bodyLarge,
                    ),
                    SizedBox(width: 30.sp),
                    const Icon(
                      IconlyBold.star,
                      color: Colors.white,
                    ),
                    SizedBox(width: 12.sp),
                    Text(
                      "${movie.voteAverage?.toStringAsFixed(1)} iMDB",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
                SizedBox(height: 18.sp),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Release date",
                          style: theme.textTheme.bodyLarge,
                        ),
                        SizedBox(height: 10.sp),
                        Text(
                          "${movie.releaseDate}",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(width: 100),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Genre",
                          style: theme.textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 48,
                          width: 150.sp,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return Center(
                                    child:
                                        Text(movie.genres?[index].name ?? ""));
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 10.sp);
                              },
                              itemCount: movie.genres?.length ?? 0),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 18.sp),
                Text(
                  "Synopsis",
                  style: theme.textTheme.headlineSmall,
                ),
                SizedBox(height: 8.sp),
                ExpandableText(
                  movie.overview ?? "",
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 4,
                  linkColor: Colors.blue,
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: 18.sp),
                Text(
                  "Related movies",
                  style: theme.textTheme.headlineSmall,
                ),
                SizedBox(height: 8.sp),
                Padding(
                  padding: EdgeInsets.only(bottom: 18.sp),
                  child: SizedBox(
                    height: 165.sp,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final movie = similarMovie[index];
                          return Container(
                            width: 100.sp,
                            decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(.1),
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Column(
                              children: [
                                NetworkImageBox(
                                    url: "${ApiUrl.image}${movie.posterPath}",
                                    radius: 15),
                                SizedBox(height: 5.sp),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text(
                                      movie.originalTitle ?? "",
                                      maxLines: 2,
                                      style: theme.textTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 30.sp);
                        },
                        itemCount: similarMovie.length),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
