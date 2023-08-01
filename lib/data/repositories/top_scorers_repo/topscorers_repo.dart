import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/top_scorers_model/top_scorers_model.dart';

class TopScorer {
  Future<TopScorersModel?> getTopScorers(int id) async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?&met=Topscorers&APIkey=e9b633c2759b431301301d00f9a9a3809b238030211a54b71e43e1e0db147f13&leagueId=$id"));
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
