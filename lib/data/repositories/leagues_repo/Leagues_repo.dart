import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: unused_import

import 'package:sports_zone/data/models/leagues_model/legues_model.dart';

class LeaguesModelsRepo {
  static const String _apiKey =
      '96dcd54337dd88e5c710d0afbdafaf7f08e390184032cf6b60baf041d7733994';
  static const String _baseUrl = 'https://apiv2.allsportsapi.com/football/';
  Future<Zsc?> getLeaguesModels() async {
    try {
      var response = await http.get(
          Uri.parse("$_baseUrl?met=Leagues&countryid=200&APIkey=$_apiKey"));

      Map<String, dynamic> deCodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        Zsc data = Zsc.fromJson(deCodedResponse);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
