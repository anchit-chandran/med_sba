import 'package:flutter/material.dart';

class ChangeSelectedAnswer extends ChangeNotifier { 
  int _selectedAnswer = -1;
  bool _hasSubmittedAnswer = false;
  bool _isCorrect = false;

  get selectedAnswer => _selectedAnswer;
  get hasSubmittedAnswer => _hasSubmittedAnswer;
  get isCorrect => _isCorrect;

  void changeAnswer(int newAnswer) {
    _selectedAnswer = newAnswer;
    notifyListeners();
  }

  void setSubmittedAnswer() {
    _hasSubmittedAnswer = true;
    notifyListeners();
  }

  void setIsCorrect() {
    _isCorrect = true;
    notifyListeners();
  }

}