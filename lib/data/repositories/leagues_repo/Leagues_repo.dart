// ignore: unused_import
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: unused_import

import 'package:sports_zone/data/models/leagues_model/legues_model.dart';

class LeaguesModelsRepo {
  Future<Zsc?> getLeaguesModels() async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?met=Leagues&countryid=200&APIkey=37362abc71829b010e3825db2d37074e6b487ef3a9af53f04f23b876420e5963"));

      Map<String, dynamic> deCodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        Zsc data = Zsc.fromJson(deCodedResponse);
        return data;
      } else {
        print("Requist faild");
        return null;
      }
    } catch (e) {
      print("Error:$e");
      return null;
    }
  }
}
