import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class Result extends StatelessWidget {
  final int numberOfCorrectAnswer;
  Result({required this.numberOfCorrectAnswer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('正解のページ'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text("答えの数は${numberOfCorrectAnswer}です。まぁまぁだね")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        child: const Text("ホームに戻る"),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                      )),
                ),
              )
            ]));
  }
}
