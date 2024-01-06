import 'package:flutter/material.dart';

class ChangeSelectedAnswer extends ChangeNotifier { 
  int _selectedAnswer = 0;

  get selectedAnswer => _selectedAnswer;

  void changeAnswer(int newAnswer) {
    _selectedAnswer = newAnswer;
    notifyListeners();
  }

}