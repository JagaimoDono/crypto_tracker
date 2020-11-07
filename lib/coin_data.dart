import 'dart:convert';

import 'package:http/http.dart' as http;

String url = 'https://rest.coinapi.io/v1/exchangerate';
String apiKey = '2C5E447E-6302-4413-B631-F4238FFF013C';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<Map<String, String>> getPrice(String currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      http.Response response =
          await http.get('$url/$crypto/$currency?apikey=$apiKey');
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double rate = decodedData['rate'];
        cryptoPrices[crypto] = rate.toStringAsFixed(2);
      } else {
        print(response.statusCode);
        throw 'Problem fetching rate data';
      }
    }
    return cryptoPrices;
  }
}
