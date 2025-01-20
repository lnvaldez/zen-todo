import "package:http/http.dart" as http;
import "dart:convert";
import "../models/quote.dart";

class QuotesService {
  final _baseUrl = Uri.parse('https://zenquotes.io/api/random');

  Future getRandomQuote() async {
    try {
      final response = await http.get(_baseUrl);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return Quote.fromJson(data[0]);
      } else {
        throw Exception('Failed to load quote: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load quote: $e');
    }
  }
}
