import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/tems_model/tems_model.dart';

class TeamsScorer {
  static const String _apiKey =
      '96dcd54337dd88e5c710d0afbdafaf7f08e390184032cf6b60baf041d7733994';
  static const String _baseUrl = 'https://apiv2.allsportsapi.com/football/';
  Future<TemsModel?> getTeams(String search, int id) async {
    try {
      http.Response response;
      if (search != '') {
        response = await http.get(Uri.parse(
            "$_baseUrl?&met=Teams&APIkey=$_apiKey&leagueId=$id&teamName=$search"));
      } else {
        response = await http.get(
            Uri.parse("$_baseUrl?&met=Teams&APIkey=$_apiKey&leagueId=$id"));
      }
      Map<String, dynamic> decodedresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        TemsModel data = TemsModel.fromJson(decodedresponse);
        return data;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
