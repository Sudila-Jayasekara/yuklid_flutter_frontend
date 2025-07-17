import 'package:yuklid_flutter_frontend/models/option.dart';

class Question {
  final String id;
  final String questionText;
  final List<Option> options;

  Question({required this.id, required this.questionText, required this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionText: json['questionText'],
      options: (json['options'] as List).map((e) => Option.fromJson(e)).toList(),
    );
  }
}
