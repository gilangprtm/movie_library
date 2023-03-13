import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/mahas/mahas_service.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await MahasService.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
