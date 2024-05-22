import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

import '../../../modules/home/model/all_movies_model.dart';

class MyHive {
  // Prevent making an instance of this class
  MyHive._();

  // Hive box to store  data
  static late Box<Movies> _moviesBox;

  // Box name, it's like the table name

  static const String _moviesBoxName = 'movies';

  /// Initialize local db (HIVE)
  /// Pass testPath only if you are testing hive
  static Future<void> init(
      {Function(HiveInterface)? registerAdapters, String? testPath}) async {
    if (testPath != null) {
      Hive.init(testPath);
    } else {
      await Hive.initFlutter();
    }
    await registerAdapters?.call(Hive);

    await initMoviesBox();
  }

  /// Initialize movies box
  static Future<void> initMoviesBox() async {
    _moviesBox = await Hive.openBox<Movies>(_moviesBoxName);
  }

  /// Save all movies to the database
  static Future<void> saveAllMovies(List<Movies> movies) async {
    try {
      await _moviesBox.clear();
      await _moviesBox.addAll(movies);
    } catch (error) {
      Logger().e("$error");
    }
  }

  /// Get all movies from Hive
  static List<Movies> getAllMovies() {
    final movies = _moviesBox.values.toList();
    return movies.cast<Movies>();
  }
}
