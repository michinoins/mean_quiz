import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  final String id;
  final String sentence;
  final bool answer;
  final String explanation;

  Quiz(
      {required this.id,
      required this.sentence,
      required this.answer,
      required this.explanation});

  factory Quiz.fromDocument(DocumentSnapshot document) {
    return Quiz(
      id: document.id,
      sentence: document['sentence'] as String,
      answer: document['answer'] as bool,
      explanation: document['explanation'] as String,
    );
  }
}
