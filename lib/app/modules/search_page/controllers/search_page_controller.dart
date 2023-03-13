import 'dart:convert';

import 'package:get/get.dart';

import '../../../mahas/mahas_config.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../models/movie_model.dart';
import '../../../routes/app_pages.dart';

class SearchPageController extends GetxController {
  var movies = RxList<MovieModel>();
  RxBool isLoad = false.obs;
  RxBool isGetAgain = false.obs;
  var page = 1;
  RxString query = "".obs;

  @override
  void onInit() {
    isLoad.value = true;
    super.onInit();
  }

  void getData(String search) async {
    isLoad.value = false;
    query.value = search;
    var r = await HttpApi.get(
        '/3/search/movie?api_key=${MahasConfig.apiKey}&query=$query&page=$page');

    if (r.success) {
      final datas = json.decode(r.body);
      final data = datas['results'];
      movies.clear();
      for (var e in data) {
        movies.add(MovieModel.fromDynamic(e));
      }
      isLoad.value = true;
    } else {
      Helper.dialogWarning(r.message);
    }
  }

  void getDataAgain() async {
    page += 1;

    var r = await HttpApi.get(
        '/3/search/movie?api_key=${MahasConfig.apiKey}&query=${query.value}&page=$page');

    if (r.success) {
      final datas = json.decode(r.body);
      final data = datas['results'];
      for (var e in data) {
        movies.add(MovieModel.fromDynamic(e));
      }
      isGetAgain.value = true;
    } else {
      Helper.dialogWarning(r.message);
    }
    isGetAgain.value = false;
  }

  void toDetail(int id) {
    Get.toNamed(
      Routes.DETAIL_MOVIE,
      parameters: {
        'id': id.toString(),
      },
    );
  }
}
