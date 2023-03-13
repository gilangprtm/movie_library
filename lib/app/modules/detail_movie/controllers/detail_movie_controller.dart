import 'package:get/get.dart';

import '../../../mahas/mahas_config.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../models/movie_detail_model.dart';

class DetailMovieController extends GetxController {
  var movie = Rxn<DetailmovieModel>();
  RxString id = "".obs;
  RxBool isLoad = false.obs;

  @override
  void onInit() {
    id.value = Get.parameters['id']!;
    getMovie();
    super.onInit();
  }

  Future<void> getMovie() async {
    var r = await HttpApi.get('/3/movie/$id?api_key=${MahasConfig.apiKey}');
    if (r.success) {
      movie.value = DetailmovieModel.fromJson(r.body);

      if (movie.value!.posterPath == null) {
        Helper.dialogWarning("Data Not Found").then((value) => Get.back());
      } else {
        isLoad.value = true;
      }
    } else {
      Helper.dialogWarning("Data Not Found").then((value) => Get.back());
    }
  }
}
