import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class DetailmovieModel {
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<DetailmovieGenresModel>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<DetailmovieProductionCompaniesModel>? productionCompanies;
  List<DetailmovieProductionCountriesModel>? productionCountries;
  DateTime? releaseDate;
  int? revenue;
  int? runtime;
  List<DetailmovieSpokenLanguagesModel>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  static DetailmovieModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static DetailmovieModel fromDynamic(dynamic dynamicData) {
    final model = DetailmovieModel();

    model.adult = MahasFormat.dynamicToBool(dynamicData['adult']);
    model.backdropPath = dynamicData['backdrop_path'];
    if (dynamicData['belongs_to_collection'] != null) {
      model.belongsToCollection =
          BelongsToCollection.fromDynamic(dynamicData['belongs_to_collection']);
    }
    model.budget = MahasFormat.dynamicToInt(dynamicData['budget']);
    if (dynamicData['genres'] != null) {
      final detailT = dynamicData['genres'] as List;
      model.genres = [];
      for (var i = 0; i < detailT.length; i++) {
        model.genres!.add(DetailmovieGenresModel.fromDynamic(detailT[i]));
      }
    }
    model.homepage = dynamicData['homepage'];
    model.id = MahasFormat.dynamicToInt(dynamicData['id']);
    model.imdbId = dynamicData['imdb_id'];
    model.originalLanguage = dynamicData['original_language'];
    model.originalTitle = dynamicData['original_title'];
    model.overview = dynamicData['overview'];
    model.popularity = MahasFormat.dynamicToDouble(dynamicData['popularity']);
    model.posterPath = dynamicData['poster_path'];
    if (dynamicData['production_companies'] != null) {
      final detailT = dynamicData['production_companies'] as List;
      model.productionCompanies = [];
      for (var i = 0; i < detailT.length; i++) {
        model.productionCompanies!
            .add(DetailmovieProductionCompaniesModel.fromDynamic(detailT[i]));
      }
    }
    if (dynamicData['production_countries'] != null) {
      final detailT = dynamicData['production_countries'] as List;
      model.productionCountries = [];
      for (var i = 0; i < detailT.length; i++) {
        model.productionCountries!
            .add(DetailmovieProductionCountriesModel.fromDynamic(detailT[i]));
      }
    }
    model.releaseDate =
        MahasFormat.dynamicToDateTime(dynamicData['release_date']);
    model.revenue = MahasFormat.dynamicToInt(dynamicData['revenue']);
    model.runtime = MahasFormat.dynamicToInt(dynamicData['runtime']);
    if (dynamicData['spoken_languages'] != null) {
      final detailT = dynamicData['spoken_languages'] as List;
      model.spokenLanguages = [];
      for (var i = 0; i < detailT.length; i++) {
        model.spokenLanguages!
            .add(DetailmovieSpokenLanguagesModel.fromDynamic(detailT[i]));
      }
    }
    model.status = dynamicData['status'];
    model.tagline = dynamicData['tagline'];
    model.title = dynamicData['title'];
    model.video = MahasFormat.dynamicToBool(dynamicData['video']);
    model.voteAverage =
        MahasFormat.dynamicToDouble(dynamicData['vote_average']);
    model.voteCount = MahasFormat.dynamicToInt(dynamicData['vote_count']);

    return model;
  }
}

class DetailmovieSpokenLanguagesModel {
  String? iso6391;
  String? name;

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static fromDynamic(dynamic dynamicData) {
    final model = DetailmovieSpokenLanguagesModel();

    model.iso6391 = dynamicData['iso_639_1'];
    model.name = dynamicData['name'];

    return model;
  }
}

class DetailmovieProductionCountriesModel {
  String? iso31661;
  String? name;

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static fromDynamic(dynamic dynamicData) {
    final model = DetailmovieProductionCountriesModel();

    model.iso31661 = dynamicData['iso_3166_1'];
    model.name = dynamicData['name'];

    return model;
  }
}

class DetailmovieProductionCompaniesModel {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static fromDynamic(dynamic dynamicData) {
    final model = DetailmovieProductionCompaniesModel();

    model.id = MahasFormat.dynamicToInt(dynamicData['id']);
    model.logoPath = dynamicData['logo_path'];
    model.name = dynamicData['name'];
    model.originCountry = dynamicData['origin_country'];

    return model;
  }
}

class DetailmovieGenresModel {
  int? id;
  String? name;

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static fromDynamic(dynamic dynamicData) {
    final model = DetailmovieGenresModel();

    model.id = MahasFormat.dynamicToInt(dynamicData['id']);
    model.name = dynamicData['name'];

    return model;
  }
}

class BelongsToCollection {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  static BelongsToCollection fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static BelongsToCollection fromDynamic(dynamic dynamicData) {
    final model = BelongsToCollection();

    model.id = MahasFormat.dynamicToInt(dynamicData['id']);
    model.name = dynamicData['name'];
    model.posterPath = dynamicData['poster_path'];
    model.backdropPath = dynamicData['backdrop_path'];

    return model;
  }
}
