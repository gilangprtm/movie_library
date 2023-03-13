import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../firebase_options.dart';
import '../controller/open_controller.dart';
import 'mahas_config.dart';

final remoteConfig = FirebaseRemoteConfig.instance;
final auth = FirebaseAuth.instance;

class MahasService {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // transparent status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    try {
      Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // open controller
      await firebaseInitialization.then((value) {
        Get.put(OpenController());
      });

      // remote config
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ));
      await remoteConfig.fetchAndActivate();
      MahasConfig.urlApi = remoteConfig.getString('api');
      MahasConfig.apiKey = remoteConfig.getString('key');
    } catch (e) {
      Get.put(OpenController());
    }

    // // hive local storage
    // await Hive.initFlutter();
    // mainStorage = await Hive.openBox('mainStorage');
    // await ProfileService.loadDataFromDB();
    // await JadwalService.loadDataFromDB();

    HttpOverrides.global = MyHttpOverrides();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
