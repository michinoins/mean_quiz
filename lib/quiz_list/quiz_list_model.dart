import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/quiz.dart';

class QuizListModel {
  List<Quiz>? _quizList;

  Future<List<Quiz>> fetchBookList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('quiz').get();

    final List<Quiz> quizList = snapshot.docs.map((DocumentSnapshot document) {
      return Quiz.fromDocument(document);
    }).toList();

    return quizList;
  }
}
