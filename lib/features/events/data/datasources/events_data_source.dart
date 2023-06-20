import 'dart:convert';

import 'package:http/http.dart' as http;

class EventsDataSource {
  Future<Map<String, dynamic>> fetchEventsById(int id) async {
    Uri url = Uri.parse(
        "https://fuksiarz.pl/rest/market/categories/multi/${id}/events");

    final response = await http.get(url);

    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
