import 'package:hive/hive.dart';

part 'all_movies_model.g.dart';

@HiveType(typeId: 0)
class AllMovies extends HiveObject {
  @HiveField(0)
  int? page;

  @HiveField(1)
  List<Movies>? results;

  @HiveField(2)
  int? totalPages;

  @HiveField(3)
  int? totalResults;

  AllMovies({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  AllMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Movies.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }
}

@HiveType(typeId: 1)
class Movies extends HiveObject {
  @HiveField(0)
  bool? adult;

  @HiveField(1)
  String? backdropPath;

  @HiveField(2)
  List<int>? genreIds;

  @HiveField(3)
  int? id;

  @HiveField(4)
  String? originalLanguage;

  @HiveField(5)
  String? originalTitle;

  @HiveField(6)
  String? overview;

  @HiveField(7)
  double? popularity;

  @HiveField(8)
  String? posterPath;

  @HiveField(9)
  String? releaseDate;

  @HiveField(10)
  String? title;

  @HiveField(11)
  bool? video;

  @HiveField(12)
  double? voteAverage;

  @HiveField(13)
  int? voteCount;

  Movies({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Movies.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds =
        json['genre_ids'] != null ? List<int>.from(json['genre_ids']) : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['backdrop_path'] = backdropPath;
    map['genre_ids'] = genreIds;
    map['id'] = id;
    map['original_language'] = originalLanguage;
    map['original_title'] = originalTitle;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    map['release_date'] = releaseDate;
    map['title'] = title;
    map['video'] = video;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }
}
