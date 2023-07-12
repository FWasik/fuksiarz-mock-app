import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchDataSource {
  Future<Map<String, dynamic>> getSearchEventsByPattern(String pattern) async {
    final response = await http.post(
        Uri.parse("https://fuksiarz.pl/rest/search/events/quick-search/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "areas": ["LIVE_EVENT", "PREMATCH_EVENT"],
          "languageCode": "pl",
          "mergeLanguages": true,
          "modes": ["PREFIX", "INFIX"],
          "pattern": pattern
        }));

    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
