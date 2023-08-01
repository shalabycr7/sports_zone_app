import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/tems_model/tems_model.dart';

class TeamsScorer {
  Future<TemsModel?> getTeams(String search, int id) async {
    try {
      http.Response response;
      if (search != '') {
        response = await http.get(Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Teams&APIkey=e9b633c2759b431301301d00f9a9a3809b238030211a54b71e43e1e0db147f13&leagueId=$id&teamName=$search"));
      } else {
        response = await http.get(Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Teams&APIkey=e9b633c2759b431301301d00f9a9a3809b238030211a54b71e43e1e0db147f13&leagueId=$id"));
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
