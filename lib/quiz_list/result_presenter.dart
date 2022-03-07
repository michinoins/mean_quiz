import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import '../entity/quiz.dart';

class ResultPresenter {
  Future show(
    BuildContext context, {
    required Quiz model,
    required bool correct,
  }) {
    return showDialog<void>(
        context: context,
        builder: (context) {
          final quiz = model.sentence;
          final answer = model.answer;
          final explanation = model.explanation;
          return AlertDialog(
            title: SizedBox(
              height: 60,
              child: FlareActor(
                'assets/animation/${correct ? 'success' : 'failure'}.flr',
                animation: 's',
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "ここはなに?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(explanation),
              ],
            ),
            actions: [
              FlatButton(
                child: const Text('NEXT'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
