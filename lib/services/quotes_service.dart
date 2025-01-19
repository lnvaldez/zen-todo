import "package:http/http.dart" as http;
import "dart:convert";
import "../models/quote.dart";

class QuotesService {
  static const String _baseUrl = 'https://zenquotes.io/api/random';

  Future getRandomQuote() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return Quote.fromJson(data[0]);
      } else {
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      throw Exception('Failed to load quote: $e');
    }
  }
}
