import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class MovieModel {
  bool? adult;
  String? backdropPath;
  List<MovieGenreIdsModel>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? name;

  MovieModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static MovieModel fromDynamic(dynamic dynamicData) {
    final model = MovieModel();

    model.adult = MahasFormat.dynamicToBool(dynamicData['adult']);
    model.backdropPath = dynamicData['backdrop_path'];
    if (dynamicData['genre_ids'] != null) {
      final detailT = dynamicData['genre_ids'] as List;
      model.genreIds = [];
      for (var i = 0; i < detailT.length; i++) {
        model.genreIds!.add(MovieGenreIdsModel.fromDynamic(detailT[i]));
      }
    }
    model.id = MahasFormat.dynamicToInt(dynamicData['id']);
    model.originalLanguage = dynamicData['original_language'];
    model.name = dynamicData['name'];
    model.originalTitle = dynamicData['original_title'];
    model.overview = dynamicData['overview'];
    model.popularity = MahasFormat.dynamicToDouble(dynamicData['popularity']);
    model.posterPath = dynamicData['poster_path'];
    model.releaseDate =
        MahasFormat.dynamicToDateTime(dynamicData['release_date']);
    model.title = dynamicData['title'];
    model.video = MahasFormat.dynamicToBool(dynamicData['video']);
    model.voteAverage =
        MahasFormat.dynamicToDouble(dynamicData['vote_average']);
    model.voteCount = MahasFormat.dynamicToInt(dynamicData['vote_count']);

    return model;
  }
}

class MovieGenreIdsModel {
  MovieGenreIdsModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static MovieGenreIdsModel fromDynamic(dynamic dynamicData) {
    final model = MovieGenreIdsModel();

    return model;
  }
}
