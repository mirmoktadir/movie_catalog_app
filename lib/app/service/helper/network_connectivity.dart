import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../components/global-widgets/my_snackbar.dart';
import '../../modules/home/controllers/home_controller.dart';

final homeController = Get.put(HomeController());

class NetworkConnectivity {
  static StreamController<bool> connectivityController =
      StreamController<bool>.broadcast();

  static bool _isListenerInitialized = false;
  static int connectionChangeCount = 0;
  static bool _wasConnected = false;

  static Future<bool> isNetworkAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    bool isConnected = (connectivityResult != ConnectivityResult.none);

    connectivityController.add(isConnected);

    return isConnected;
  }

  static void initConnectivityListener() {
    if (!_isListenerInitialized) {
      _isListenerInitialized = true;
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        bool isConnected = (result != ConnectivityResult.none);
        connectivityController.add(isConnected);
        if (_wasConnected) {
          // Disconnected after being connected
          connectionChangeCount++;
          if (connectionChangeCount > 1) {
            // First or later disconnection
            _runDisconnectedOperations();
          }
        } else if (!_wasConnected) {
          // Connected after being disconnected
          connectionChangeCount++;
          if (connectionChangeCount > 1) {
            // First or later reconnection
            _runConnectedOperations();
          }
        }
        _wasConnected = isConnected;
      });
    }
  }

  static void _runConnectedOperations() async {
    await homeController.getAllMovies();
    await 2.delay();
    MySnackBar.showSnackBar(
        title: "Connection restored!", message: 'Data loaded from network');
  }

  static void _runDisconnectedOperations() async {
    await 2.delay();
    MySnackBar.showErrorSnackBar(
        title: "Connection lost!", message: 'Data loaded from memory');
  }
}
