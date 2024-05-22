import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_catalog_app/app/data/local/hive/hive_adapters.dart';
import 'package:movie_catalog_app/my_app.dart';

import 'app/data/local/my_shared_pref.dart';
import 'app/service/helper/network_connectivity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Device orientation
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  // init hive and adapters
   await HiveAdapters.registerAll();

  // Device info
  //  DeviceInfoHelper.initializeDeviceInfo();

  // Shared pref
  await MySharedPref.init();

  // inti fcm services
  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );

  // initialize local notifications
  // await NotificationHelper().initNotification();

  // Connectivity
  Future.delayed(Duration.zero, () {
    NetworkConnectivity.initConnectivityListener();
  });

  ///****************************************** My App ************************************///

  runApp(
    const MyApp(),
  );
}
