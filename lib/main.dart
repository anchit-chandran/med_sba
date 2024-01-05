// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35.0,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Progress(
                questionNumber: questionNumber,
                questionTotal: questionTotal,
              ),
              QuestionStem(
                stem: stem,
              )
            ],
          ),
        ),
      ),
    );
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
          style: TextStyle(),
        ),
      ],
    );
  }
}
