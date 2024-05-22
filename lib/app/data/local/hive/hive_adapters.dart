import '../../../modules/home/model/all_movies_model.dart';
import 'my_hive.dart';

class HiveAdapters {
  static Future<void> registerAll() async {
    await MyHive.init(registerAdapters: (hive) {
      hive.registerAdapter(AllMoviesAdapter());
      hive.registerAdapter(MoviesAdapter());
    });
  }
}
