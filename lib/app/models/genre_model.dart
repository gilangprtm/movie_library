import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class GenreModel {
  int? id;
  String? name;

  GenreModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static GenreModel fromDynamic(dynamic dynamicData) {
    final model = GenreModel();

    model.id = MahasFormat.dynamicToInt(dynamicData['id']);
    model.name = dynamicData['name'];

    return model;
  }
}
