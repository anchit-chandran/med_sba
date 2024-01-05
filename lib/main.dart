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

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: colorScheme.background,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Progress(
              questionNumber: questionNumber,
              questionTotal: questionTotal,
            ),
          ],
        ),
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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Row(
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
      ),
    );
  }
}
