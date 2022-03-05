import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/quiz.dart';

import '../result.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  void initState() {
    print("init State");
    super.initState();
    Future(() async {
      await Future.delayed(Duration(seconds: 5));
    });
    setQuiz();
  }

  Future<List<Quiz>> setQuiz() {
    // 検索結果は、一旦はFuture型で取得
    Future<QuerySnapshot<Map<String, dynamic>>> snapshot =
        FirebaseFirestore.instance.collection("quiz").get();
    print("inSetQuiz");

    // ドキュメントを取得
    Future<List<Quiz>> quiz = snapshot.then(
        (event) => event.docs.map((doc) => Quiz.fromDocument(doc)).toList());

    print("after get");
    return quiz;
  }

  static const List<String> questionSentences = [
    "「テトリス（ゲーム）」を開発したのは、日本人だ。",
    "生きている間は、有名な人であっても広辞苑に載ることはない。",
    "現在、2000円札は製造を停止している。",
    "パトカーは、取り締まっている最中であれば、どこでも駐車違反になることはない。",
    "昆虫の中には、口で呼吸する昆虫もいる。",
  ];
  static const List<bool> answers = [false, false, true, true, false];

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
              print("outHasData");
              print(snapshot.hasData);
              if (snapshot.hasData) {
                print("inHasData");
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
                                            bool answer =
                                                answers[questionNumber];
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
