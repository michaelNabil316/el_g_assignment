import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class CurrencyApi {
  Future<dynamic> getCurrencyFromTo(
      double amount, String fromCurrency, String toCurrency) async {
    try {
      // var url = ('https://api.openweathermap.org/');
      // http.Response response = await http.get(Uri.parse(url));
      await Future.delayed(const Duration(seconds: 2));
      Map map = {"USD_PHP": 46.211, "PHP_USD": 0.02163987};
      http.Response response = http.Response(jsonEncode(map), 200);
      if (response.statusCode == 200) {
        final double value = jsonDecode(response.body)['USD_PHP'] * amount;
        return {"error": false, "value": value};
      }
      return {"error": true};
    } catch (error) {
      log("getCurrencyFromTo error: $error");
      return {"error": true};
    }
  }
}
