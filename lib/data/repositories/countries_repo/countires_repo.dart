import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sports_zone/data/models/countries_model/countries_model.dart';

class CountiersModelsRepo {
  static const String _apiKey =
      '96dcd54337dd88e5c710d0afbdafaf7f08e390184032cf6b60baf041d7733994';
  static const String _baseUrl = 'https://apiv2.allsportsapi.com/football/';
  Future<CountiersModels?> getCountiersModels() async {
    try {
      var response =
          await http.get(Uri.parse("$_baseUrl?met=Countries&APIkey=$_apiKey"));

      Map<String, dynamic> deCodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        CountiersModels data = CountiersModels.fromJson(deCodedResponse);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
