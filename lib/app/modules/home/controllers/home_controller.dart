// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_library/app/routes/app_pages.dart';

import '../../../mahas/mahas_config.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../models/genre_model.dart';
import '../../../models/movie_model.dart';

class HomeController extends GetxController {
  var genres = RxList<GenreModel>();
  var movies = RxList<MovieModel>();
  var trend = RxList<MovieModel>();

  RxBool isLoad = false.obs;
  RxBool isInit = false.obs;
  RxInt selected = 99.obs;
  var id;
  var idGenre;
  final count = 0.obs;
  @override
  void onInit() {
    isInit.value = true;
    genre();
    getMovie(id);
    trending();
    super.onInit();
  }

  Future<void> genre() async {
    var r =
        await HttpApi.get('/3/genre/movie/list?api_key=${MahasConfig.apiKey}');
    if (r.success) {
      final datas = json.decode(r.body);
      final data = datas['genres'];
      genres.clear();
      for (var e in data) {
        genres.add(GenreModel.fromDynamic(e));
      }
    } else {
      Helper.dialogWarning(r.message);
    }
  }

  Future<void> getMovie(int id) async {
    idGenre = id;
    var r = await HttpApi.get(
        '/3/discover/movie?api_key=${MahasConfig.apiKey}&with_genres=$id');
    if (r.success) {
      final datas = json.decode(r.body);
      final data = datas['results'];
      movies.clear();
      for (var e in data) {
        movies.add(MovieModel.fromDynamic(e));
      }
      isLoad.value = true;
      isInit.value = false;
    } else {
      Helper.dialogWarning(r.message);
    }
  }

  Future<void> trending() async {
    var r =
        await HttpApi.get('/3/trending/all/day?api_key=${MahasConfig.apiKey}');
    if (r.success) {
      final datas = json.decode(r.body);
      final data = datas['results'];
      trend.clear();
      for (var e in data) {
        trend.add(MovieModel.fromDynamic(e));
      }
    } else {
      Helper.dialogWarning(r.message);
    }
  }

  void toDetail(int id) {
    Get.toNamed(
      Routes.DETAIL_MOVIE,
      parameters: {
        'id': id.toString(),
      },
    );
  }

  void toListMovieGenre() {
    Get.toNamed(
      Routes.LIST_MOVIE,
      parameters: {
        'id': idGenre.toString(),
        'from': "genre",
      },
    );
  }

  void toListPopular() {
    Get.toNamed(
      Routes.LIST_MOVIE,
      parameters: {
        'id': idGenre.toString(),
        'from': "popular",
      },
    );
  }

  void toSearch() {
    Get.toNamed(Routes.SEARCH_PAGE);
  }
}
