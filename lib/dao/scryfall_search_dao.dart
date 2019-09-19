import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mtg_cards_info/model/scryfall_search_model.dart';

const String api_url = 'https://api.scryfall.com/cards/search?q=name%3D';

class ScryfallSearchDao {
  static Future<ScryfallSearchModel> fetch(String url, String text) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文亂碼
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      ScryfallSearchModel model = ScryfallSearchModel.fromJson(result);
      model.keyword = text;
      return model;
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}
