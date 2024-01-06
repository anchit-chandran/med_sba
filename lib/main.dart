// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:med_sba/change_selected_answer.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ChangeSelectedAnswer(),
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
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    const questionNumber = 1;
    const questionTotal = 10;
    const stem =
        "A 65-year-old male patient presents to the emergency department with central chest pain radiating to his left arm, which started 2 hours ago. He is sweating profusely and looks pale. His past medical history includes hypertension and type 2 diabetes mellitus. An ECG shows ST-segment elevation in leads II, III, and aVF. His blood pressure is 135/85 mmHg, and his pulse is 90 beats per minute.\n\nWhich of the following is the most appropriate next step in management?";

    const answers = {
      'answer1': 'Immediate administration of a sublingual nitrate',
      'answer2': 'Urgent coronary angiography',
      'answer3': 'Intravenous administration of a fibrinolytic agent',
      'answer4': 'High-dose oral aspirin and a beta-blocker',
      'answer5': 'Observation and repeat ECG in one hour',
    };
    const correctAnswer = 1;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: Column(
                children: [
                  Progress(
                    questionNumber: questionNumber,
                    questionTotal: questionTotal,
                  ),
                  QuestionStem(
                    stem: stem,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                child: Answers(
                  answers: answers,
                  correctAnswer: correctAnswer,
                ),
              ),
            ),
            Expanded(
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
        Provider.of<ChangeSelectedAnswer>(context, listen: false)
            .selectedAnswer;

    // Then notify the provider that the user has submitted an answer.
    Provider.of<ChangeSelectedAnswer>(context, listen: false)
        .setSubmittedAnswer();

    if (selectedAnswer == widget.correctAnswer) {
      Provider.of<ChangeSelectedAnswer>(context, listen: false).setIsCorrect();
    } else {
      print('wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    var hasSubmittedAnswer =
        Provider.of<ChangeSelectedAnswer>(context, listen: false)
            .hasSubmittedAnswer;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton.outlined(
          onPressed: () {
            print('pressed prev q');
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
          onPressed: () {
            print('pressed next q');
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
  }) {
    if (isIconColor) {
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

    var selectedAnswer = Provider.of<ChangeSelectedAnswer>(
      context,
    ).selectedAnswer;

    bool hasSubmittedAnswer = Provider.of<ChangeSelectedAnswer>(
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
        isSelected || (hasSubmittedAnswer && isCorrect) ? Icons.circle_rounded : Icons.circle_outlined,
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
          Provider.of<ChangeSelectedAnswer>(context, listen: false)
              .changeAnswer(answerNum);
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
