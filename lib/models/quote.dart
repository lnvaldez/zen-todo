class Quote {
  final String text;
  final String author;

  Quote({
    required this.text,
    required this.author,
  });

  factory Quote.fromJson(Map json) => Quote(
        text: json['q'],
        author: json['a'],
      );
}
