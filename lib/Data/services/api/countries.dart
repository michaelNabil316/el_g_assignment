import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class CountriesApi {
  Future<dynamic> getCountriesNames() async {
    try {
      var url = ('https://flagcdn.com/en/codes.json');
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return {"error": false, "value": jsonDecode(response.body)};
      }
      return {"error": true};
    } catch (error) {
      log("getCountriesNames error: $error");
      return {"error": true};
    }
  }
}
