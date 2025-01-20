import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/quotes_service.dart';
import '../models/quote.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({Key? key}) : super(key: key);

  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State {
  final _quotesService = QuotesService();
  Quote? _currentQuote;
  bool _isLoading = false;

  Future _fetchQuote() async {
    setState(() => _isLoading = true);
    try {
      final quote = await _quotesService.getRandomQuote();
      setState(() => _currentQuote = quote);
    } catch (e) {
      print("Error fetching quote: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Quotes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/zen_logo.svg',
              height: 100,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchQuote,
              child: Text(_isLoading ? 'Loading...' : 'Get Quote'),
            ),
            if (_currentQuote != null) ...[
              const SizedBox(height: 32),
              Text(
                _currentQuote!.text,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '- ${_currentQuote!.author}',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
