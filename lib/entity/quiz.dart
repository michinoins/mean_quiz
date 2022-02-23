import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  final String id;
  final String quizSentence;
  final bool answer;
  final String explanation;

  Quiz(
      {required this.id,
      required this.quizSentence,
      required this.answer,
      required this.explanation});

  const Quiz._(this.id, this.quizSentence, this.answer, this.explanation);

  factory Quiz.fromDocument(DocumentSnapshot document) {
    return Quiz(
      id: document.id,
      quizSentence: document['quizSentence'] as String,
      answer: document['answer'] as bool,
      explanation: document['explanation'] as String,
    );
  }
}
