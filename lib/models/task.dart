class Task {
  final String id;
  final String title;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  Map toJson() => {
        'id': id,
        "title": title,
        "isCompleted": isCompleted,
      };

  factory Task.fromJson(Map json) => Task(
        id: json['id'],
        title: json['title'],
        isCompleted: json['isCompleted'],
      );
}
