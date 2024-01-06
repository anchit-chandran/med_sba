// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:med_sba/question_notifier.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => QuestionNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 0, 28, 168),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const QuestionPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class QuestionPage extends StatefulWidget {
  final String title;

  const QuestionPage({
    super.key,
    required this.title,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  void changeQuestion(context, int newQuestion) {
    Provider.of<QuestionNotifier>(context, listen: false)
        .changeQuestion(newQuestion);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final questionTotal = Provider.of<QuestionNotifier>(context, listen: false)
        .getTotalQuestions();

    final currentQuestionData =
        Provider.of<QuestionNotifier>(context).currentQuestionData;
    final questionNumber = currentQuestionData['questionNumber'];
    final stem = currentQuestionData['stem'];
    final answers = currentQuestionData['answers'];
    final correctAnswer = currentQuestionData['correctAnswer'];

    return Scaffold(
      appBar: AppBar(
        title: Progress(
          questionNumber: questionNumber,
          questionTotal: questionTotal,
        ),
      ),
      backgroundColor: colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      QuestionStem(
                        stem: stem,
                      ),
                    ],
                  ),
                  Answers(
                    answers: answers,
                    correctAnswer: correctAnswer,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30.0,
              ),
              child: ActionButtonsRow(correctAnswer: correctAnswer),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtonsRow extends StatefulWidget {
  final int correctAnswer;

  const ActionButtonsRow({
    super.key,
    required this.correctAnswer,
  });

  @override
  State<ActionButtonsRow> createState() => _ActionButtonsRowState();
}

class _ActionButtonsRowState extends State<ActionButtonsRow> {
  void handleSubmitQuestionPress(context) {
    // First get the currently selected answer.
    var selectedAnswer =
        Provider.of<QuestionNotifier>(context, listen: false).selectedAnswer;

    // Then notify the provider that the user has submitted an answer.
    Provider.of<QuestionNotifier>(context, listen: false).setSubmittedAnswer();

    if (selectedAnswer == widget.correctAnswer) {
      Provider.of<QuestionNotifier>(context, listen: false).setIsCorrect();
    } else {
      print('wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<QuestionNotifier>(context);
    var hasSubmittedAnswer = provider.hasSubmittedAnswer;
    int currentQuestionNum = provider.currentQuestionNum;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton.outlined(
          onPressed: (currentQuestionNum == 1)
              ? null
              : () {
                  Provider.of<QuestionNotifier>(
                    context,
                    listen: false,
                  ).changeQuestion(currentQuestionNum - 1);
                },
          icon: Icon(Icons.arrow_left),
        ),
        IconButton.outlined(
          onPressed: hasSubmittedAnswer
              ? null
              : () => handleSubmitQuestionPress(context),
          icon: Icon(Icons.check),
        ),
        IconButton.outlined(
          onPressed: (currentQuestionNum == provider.getTotalQuestions())
              ? null
              : () {
                  Provider.of<QuestionNotifier>(
                    context,
                    listen: false,
                  ).changeQuestion(currentQuestionNum + 1);
                },
          icon: Icon(Icons.arrow_right),
        ),
      ],
    );
  }
}

class Answers extends StatefulWidget {
  final Map<String, String> answers;
  final int correctAnswer;

  const Answers({
    super.key,
    required this.answers,
    required this.correctAnswer,
  });

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  @override
  Widget build(BuildContext context) {
    final allAnswerRows = constructAnswerRows(answers: widget.answers);

    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: allAnswerRows,
    );
  }

  Color getAnswerColor({
    required bool isSelected,
    required bool hasSubmittedAnswer,
    required bool isCorrect,
    bool isIconColor = false,
    bool isTextColor = false,
  }) {
    if (isTextColor) {
      if (hasSubmittedAnswer) {
        if (isCorrect) {
          return Colors.green;
        } else {
          if (isSelected) {
            return Colors.red;
          } else {
            return Color.fromARGB(139, 255, 60, 79);
          }
        }
      } else {
        return Colors.white;
      }
    }

    if (isIconColor) {
      if (hasSubmittedAnswer) {
        if (isCorrect) {
          return Colors.green;
        } else {
          if (isSelected) {
            return Colors.red;
          } else {
            return Color.fromARGB(139, 255, 60, 79);
          }
        }
      } else {
        return Colors.white;
      }
    } else {
      if (isSelected) {
        if (hasSubmittedAnswer) {
          if (isCorrect) {
            return Colors.green;
          } else {
            return Colors.red;
          }
        } else {
          return Colors.white;
        }
      } else {
        return Colors.black;
      }
    }
  }

  List<Widget> constructAnswerRows({required Map<String, String> answers}) {
    List<Widget> allAnswers = [];

    var selectedAnswer = Provider.of<QuestionNotifier>(
      context,
    ).selectedAnswer;

    bool hasSubmittedAnswer = Provider.of<QuestionNotifier>(
      context,
      listen: false,
    ).hasSubmittedAnswer;

    for (var answer in answers.entries) {
      // First get the answer number from key
      int answerNum = int.parse(answer.key[answer.key.length - 1]);

      // Set true if this is the current selected answer.
      bool isSelected = answerNum == selectedAnswer;

      bool isCorrect = answerNum == widget.correctAnswer;

      // Now, set the conditional stylings.
      Icon answerIcon;
      Border answerBorder;

      // Set default styling
      answerIcon = Icon(
        isSelected || (hasSubmittedAnswer && isCorrect)
            ? Icons.circle_rounded
            : Icons.circle_outlined,
        color: getAnswerColor(
          isSelected: isSelected,
          hasSubmittedAnswer: hasSubmittedAnswer,
          isCorrect: isCorrect,
          isIconColor: true,
        ),
      );

      answerBorder = Border.all(
        color: getAnswerColor(
            isSelected: isSelected,
            hasSubmittedAnswer: hasSubmittedAnswer,
            isCorrect: isCorrect),
        width: 2.0,
      );

      // Then get the answer text
      String answerText = answer.value;

      allAnswers.add(GestureDetector(
        onTap: () {
          hasSubmittedAnswer
              ? null
              : Provider.of<QuestionNotifier>(
                  context,
                  listen: false,
                ).changeAnswer(answerNum);
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            border: answerBorder,
            borderRadius: BorderRadius.circular(20.0),
            color: Color.fromARGB(169, 0, 0, 0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    '$answerNum. $answerText',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: getAnswerColor(
                        isSelected: isSelected,
                        hasSubmittedAnswer: hasSubmittedAnswer,
                        isCorrect: isCorrect,
                        isTextColor: true,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: answerIcon,
                ),
              )
            ],
          ),
        ),
      ));
    }
    return allAnswers;
  }
}

class QuestionStem extends StatelessWidget {
  final String stem;

  const QuestionStem({
    super.key,
    required this.stem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Text(
        stem,
        textAlign: TextAlign.justify,
        style: TextStyle(),
      ),
    );
  }
}

class Progress extends StatelessWidget {
  final int questionNumber;
  final int questionTotal;

  const Progress({
    super.key,
    required this.questionNumber,
    required this.questionTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'Question $questionNumber',
          style: TextStyle(
            fontSize: 28.0,
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          '/ $questionTotal',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
