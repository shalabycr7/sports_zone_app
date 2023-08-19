import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/top_scorers_model/top_scorers_model.dart';

class TopScorer {
  static const String _apiKey =
      '96dcd54337dd88e5c710d0afbdafaf7f08e390184032cf6b60baf041d7733994';
  static const String _baseUrl = 'https://apiv2.allsportsapi.com/football/';
  Future<TopScorersModel?> getTopScorers(int id) async {
    try {
      var response = await http.get(
          Uri.parse("$_baseUrl?&met=Topscorers&APIkey=$_apiKey&leagueId=$id"));
      Map<String, dynamic> decodedresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        TopScorersModel data = TopScorersModel.fromJson(decodedresponse);
        return data;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
