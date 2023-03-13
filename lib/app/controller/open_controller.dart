import 'package:get/get.dart';

import '../routes/app_pages.dart';

class OpenController extends GetxController {
  static OpenController instance = Get.find();

  @override
  void onReady() {
    super.onReady();
    _toLogin();
  }

  void _toLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAllNamed(Routes.HOME);
  }
}
