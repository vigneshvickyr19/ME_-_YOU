import 'package:flutter/material.dart';

class HomeNavigationController extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void changeTab(int newIndex) {
    if (_index == newIndex) return;
    _index = newIndex;
    notifyListeners();
  }
}
