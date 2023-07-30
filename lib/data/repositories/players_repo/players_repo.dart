import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/plyer1_model/plyer1_model.dart';
import '../../models/tems_model/tems_model.dart';

class Players {
  Future<TemsModel?> getPlayers(String tm, int id) async {
    try {
      http.Response response;
      // https://apiv2.allsportsapi.com/football/?&playerName=Cristiano Ronaldo&met=Players&APIkey=b1adac156f26d4e1617feed2cf9ba42f054958c3a0f7b982a9bd24faa68f7252

      // team name not static
      print("this ");

      //  response = await http.get(Uri.parse("https://apiv2.allsportsapi.com/football/?&playerName=$srch&met=Players&APIkey=b1adac156f26d4e1617feed2cf9ba42f054958c3a0f7b982a9bd24faa68f7252"));

      response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?&met=Teams&APIkey=b1adac156f26d4e1617feed2cf9ba42f054958c3a0f7b982a9bd24faa68f7252&leagueId=$id&teamName=$tm"));
      Map<String, dynamic> decodedresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        TemsModel data = TemsModel.fromJson(decodedresponse);
        return data;
      } else {
        print("request failed");
        return null;
      }
    } catch (error) {
      print("erroe:$error");
      return null;
    }
  }

  Future<Plyer1Model?> getPlayer(String srch) async {
    try {
      http.Response response;
      // https://apiv2.allsportsapi.com/football/?&playerName=Cristiano Ronaldo&met=Players&APIkey=b1adac156f26d4e1617feed2cf9ba42f054958c3a0f7b982a9bd24faa68f7252

      // team name not static
      print("this ");

      response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?&playerName=$srch&met=Players&APIkey=e9b633c2759b431301301d00f9a9a3809b238030211a54b71e43e1e0db147f13"));

      Map<String, dynamic> decodedresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        Plyer1Model data = Plyer1Model.fromJson(decodedresponse);
        return data;
      } else {
        print("request failed");
        return null;
      }
    } catch (error) {
      print("erroe:$error");
      return null;
    }
  }
}
