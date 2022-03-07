import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/quiz.dart';
import 'package:flutter_app/quiz_list/result_presenter.dart';

import '../result.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final _resultPresenter = ResultPresenter();

  @override
  void initState() {
    super.initState();
  }

  Future<List<Quiz>> setQuiz() {
    // 検索結果は、一旦はFuture型で取得
    Future<QuerySnapshot<Map<String, dynamic>>> snapshot =
        FirebaseFirestore.instance.collection("quiz").get();

    // ドキュメントを取得
    Future<List<Quiz>> quiz = snapshot.then(
        (event) => event.docs.map((doc) => Quiz.fromDocument(doc)).toList());

    return quiz;
  }

  // 問題番号
  int questionNumber = 0;

  // 正解問題数
  int numOfCorrectAnswers = 0;

  @override
  Widget build(BuildContext context) {
    print("in build");
    return Scaffold(
        appBar: AppBar(
          title: Text("問題ページ"),
        ),
        body: FutureBuilder(
            future: setQuiz(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var quiz = snapshot.data as List<Quiz>;
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      Container(
                        height: 50,
                        color: Colors.red,
                        child: const Center(
                          child: Text(
                            "一旦",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            quiz.elementAt(questionNumber).sentence,
                            style: TextStyle(fontSize: 20),
                          )),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  50.0, 30.0, 50.0, 50.0),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          child: Text("まる"),
                                          onPressed: () {
                                            bool answer = quiz
                                                .elementAt(questionNumber)
                                                .answer;
                                            if (answer == true) {
                                              // 正解の処理
                                              numOfCorrectAnswers++;
                                              if (questionNumber + 1 <
                                                  quiz.length) {
                                                setState(() {
                                                  questionNumber++;
                                                });
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Result(
                                                            numberOfCorrectAnswer:
                                                                numOfCorrectAnswers)));
                                              }
                                            } else {
                                              if (questionNumber + 1 <
                                                  quiz.length) {
                                                setState(() {
                                                  questionNumber++;
                                                });
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Result(
                                                              numberOfCorrectAnswer:
                                                                  numOfCorrectAnswers,
                                                            )));
                                              }
                                            }
                                          },
                                        )),
                                    SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          child: const Text("ばつ"),
                                          onPressed: () {
                                            bool answer = quiz
                                                .elementAt(questionNumber)
                                                .answer;
                                            if (answer == false) {
                                              // 正解の処理
                                              numOfCorrectAnswers++;
                                              if (questionNumber + 1 <
                                                  quiz.length) {
                                                setState(() {
                                                  questionNumber++;
                                                });
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Result(
                                                              numberOfCorrectAnswer:
                                                                  numOfCorrectAnswers,
                                                            )));
                                              }
                                            } else {
                                              if (questionNumber + 1 <
                                                  quiz.length) {
                                                setState(() {
                                                  questionNumber++;
                                                });
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Result(
                                                              numberOfCorrectAnswer:
                                                                  numOfCorrectAnswers,
                                                            )));
                                              }
                                            }
                                          },
                                        ))
                                  ])))
                    ]));
              }
              // while waiting for data to arrive, show a spinning indicator
              return const CircularProgressIndicator();
            }));
  }
}
