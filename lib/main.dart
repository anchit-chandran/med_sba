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
      home: const QuestionPage(),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({
    super.key,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Progress(),
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
                      QuestionStem(),
                    ],
                  ),
                  Answers(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30.0,
              ),
              child: ActionButtonsRow(),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtonsRow extends StatefulWidget {
  const ActionButtonsRow({
    super.key,
  });

  @override
  State<ActionButtonsRow> createState() => _ActionButtonsRowState();
}

class _ActionButtonsRowState extends State<ActionButtonsRow> {
  void handleSubmitQuestionPress(context) {
    var provider = Provider.of<QuestionNotifier>(context, listen: false);

    // First get the currently selected answer.
    var selectedAnswer = provider.getCurrentAnswerSelected();

    // Then notify the provider that the user has submitted an answer.
    provider.setSubmittedAnswer();

    if (selectedAnswer == provider.getCurrentCorrectAnswer()) {
      print('right!');
    } else {
      print('wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionNotifier>(
      builder: (context, provider, child) {
        bool hasSubmittedAnswer = provider.hasSubmittedAnswer();
        int currentQuestionNum = provider.currentQuestionNum;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton.outlined(
              onPressed: (currentQuestionNum == 1)
                  ? null
                  : () {
                      provider.changeQuestion(currentQuestionNum - 1);
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
                      provider.changeQuestion(currentQuestionNum + 1);
                    },
              icon: Icon(Icons.arrow_right),
            ),
          ],
        );
      },
    );
  }
}

class Answers extends StatefulWidget {
  const Answers({
    super.key,
  });

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  @override
  Widget build(BuildContext context) {
    final allAnswerRows = constructAnswerRows(context);

    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: allAnswerRows,
    );
  }

  Color getAnswerColor({
    required bool isSelected,
    required bool hasSubmittedAnswer,
    required bool isCorrect,
    required String widgetType,
  }) {
    Color selectedCorrectColor = isCorrect ? Colors.green : Colors.red;
    Color nonSelectedCorrectColor = isCorrect ? Colors.green : Colors.red;

    if (widgetType == 'icon' || widgetType == 'text') {
      if (hasSubmittedAnswer) {
        if (isSelected) {
          return selectedCorrectColor; // selected answer after submission
        } else {
          return nonSelectedCorrectColor; // unselected answer after submission
        }
      } else {
        return Colors.white; // before submission
      }
    } else if (widgetType == 'border') {
      if (!hasSubmittedAnswer) return Colors.black;

      if (isCorrect) return Colors.green;

      // Non selected, incorrect answer
      if (!isSelected) return Color.fromARGB(68, 244, 67, 54);

      // Selected, incorrect answer
      return Colors.red;
    } else {
      throw Exception('Invalid widgetType');
    }
  }

  List<Widget> constructAnswerRows(context) {
    List<Widget> allAnswers = [];

    var provider = Provider.of<QuestionNotifier>(context);
    Map<String, String> currentQuestionAnswers =
        provider.getCurrentQuestionAnswers();

    for (var answer in currentQuestionAnswers.entries) {
      // First get the answer number from key
      int answerNum = int.parse(answer.key[answer.key.length - 1]);

      // Get some state variables
      bool isSelected = answerNum == provider.getCurrentAnswerSelected();
      bool hasSubmittedAnswer = provider.hasSubmittedAnswer();
      bool isCorrect = answerNum == provider.getCurrentCorrectAnswer();

      // Now, set the conditional stylings.
      Icon answerIcon;
      Border answerBorder;

      // Set default styling
      answerIcon = Icon(
        isSelected ? Icons.circle_rounded : Icons.circle_outlined,
        color: getAnswerColor(
          isSelected: isSelected,
          hasSubmittedAnswer: hasSubmittedAnswer,
          isCorrect: isCorrect,
          widgetType: 'icon',
        ),
      );

      answerBorder = Border.all(
        color: getAnswerColor(
            isSelected: isSelected,
            hasSubmittedAnswer: hasSubmittedAnswer,
            isCorrect: isCorrect,
            widgetType: 'border'),
        width: 2.0,
      );

      // Then get the answer text
      String answerText = answer.value;

      allAnswers.add(GestureDetector(
        onTap: () {
          hasSubmittedAnswer ? null : provider.changeAnswer(answerNum);
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
                        widgetType: 'text',
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
  const QuestionStem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<QuestionNotifier>(context);
    String stem = provider.getCurrentQuestionStem();

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
  const Progress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<QuestionNotifier>;
    int questionNumber = provider(context).currentQuestionNum;
    int questionTotal = provider(context).getTotalQuestions();

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
