import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sports_zone/data/models/countries_model/countries_model.dart';

class CountiersModelsRepo {
  static const String _apiKey =
      'c4cf9b83dd238694de4a6188f2a57c794070af1fa35646b5e3285b225f9a8482';
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
