// ignore: unused_import
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sports_zone/data/models/Countires/countries_model.dart';

class CountiersModelsRepo {
  Future<CountiersModels?> getCountiersModels() async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=b1adac156f26d4e1617feed2cf9ba42f054958c3a0f7b982a9bd24faa68f7252"));

      Map<String, dynamic> deCodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        CountiersModels data = CountiersModels.fromJson(deCodedResponse);
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
