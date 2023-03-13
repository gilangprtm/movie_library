// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/get.dart';

import '../../../mahas/mahas_config.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../models/movie_model.dart';
import '../../../routes/app_pages.dart';

class ListMovieController extends GetxController {
  var movies = RxList<MovieModel>();
  RxBool isLoad = false.obs;
  RxBool isGetAgain = false.obs;
  var itemHeight = 300;

  var id;
  var page = 1;
  var from;
  var r;

  @override
  void onInit() {
    id = Get.parameters['id']!;
    from = Get.parameters['from']!;
    getMovie(id);
    super.onInit();
  }

  Future<void> getMovie(String id) async {
    if (from == "genre") {
      r = await HttpApi.get(
          '/3/discover/movie?api_key=${MahasConfig.apiKey}&with_genres=$id&page=$page');
    } else {
      r = await HttpApi.get(
          '/3/trending/all/day?api_key=${MahasConfig.apiKey}');
    }
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
    if (from == "genre") {
      r = await HttpApi.get(
          '/3/discover/movie?api_key=${MahasConfig.apiKey}&with_genres=$id&page=$page');
    } else {
      r = await HttpApi.get(
          '/3/trending/all/day?api_key=${MahasConfig.apiKey}&page=$page');
    }
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
