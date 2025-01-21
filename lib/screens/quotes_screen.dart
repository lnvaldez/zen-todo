import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/quotes_service.dart';
import '../models/quote.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final _quotesService = QuotesService();
  Quote? _currentQuote;
  bool _isLoading = false;

  Future _fetchQuote() async {
    setState(() => _isLoading = true);
    try {
      final quote = await _quotesService.getRandomQuote();
      setState(() => _currentQuote = quote);
    } catch (e) {
      if (!mounted) return;
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
      appBar: AppBar(
        title: const Text(
          'Daily Quotes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/zen_logo.svg',
                height: 100,
                colorFilter:
                    const ColorFilter.mode(Colors.green, BlendMode.srcIn),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Color.fromRGBO(91, 177, 94, 1))),
                onPressed: _isLoading ? null : _fetchQuote,
                child: Text(
                  _isLoading ? 'Loading...' : 'Get Quote',
                  style: const TextStyle(color: Colors.white),
                ),
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
      ),
    );
  }
}
