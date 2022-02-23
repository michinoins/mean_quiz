import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/quiz.dart';
import 'package:flutter_app/result.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  // 実際はDBから取ってくる
  static const List<String> questions = [
    "問題1",
    "問題2",
    "問題3",
    "問題4",
    "問題5",
  ];

  String getQuiz() {
    // 返り値として渡すためのドキュメント数を入れる変数

    // 検索結果は、一旦はFuture型で取得
    Future<QuerySnapshot<Map<String, dynamic>>> snapshot =
        FirebaseFirestore.instance.collection("quiz").get();

    // ドキュメント数を取得。
    snapshot.then((value) {
      var quizes = value.docs.map((doc) => Quiz.fromDocument(doc));
      quizes.forEach((element) {
        print("quizes" + element.quizSentence);
      });
      print("問題" + value.docs[0].id);
    });

    return "";
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
    getQuiz();
    return Scaffold(
        appBar: AppBar(
          title: Text("問題ページ"),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                questionSentences[questionNumber],
                style: TextStyle(fontSize: 20),
              )),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 50.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              child: Text("まる"),
                              onPressed: () {
                                bool answer = answers[questionNumber];
                                if (answer == true) {
                                  // 正解の処理
                                  numOfCorrectAnswers++;
                                  if (questionNumber + 1 < questions.length) {
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
                                  if (questionNumber + 1 < questions.length) {
                                    setState(() {
                                      questionNumber++;
                                    });
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Result(
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
                                bool answer = answers[questionNumber];
                                if (answer == false) {
                                  // 正解の処理
                                  numOfCorrectAnswers++;
                                  if (questionNumber + 1 < questions.length) {
                                    setState(() {
                                      questionNumber++;
                                    });
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Result(
                                                  numberOfCorrectAnswer:
                                                      numOfCorrectAnswers,
                                                )));
                                  }
                                } else {
                                  if (questionNumber + 1 < questions.length) {
                                    setState(() {
                                      questionNumber++;
                                    });
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Result(
                                                  numberOfCorrectAnswer:
                                                      numOfCorrectAnswers,
                                                )));
                                  }
                                }
                              },
                            ))
                      ])))
        ])));
  }
}
