import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isTimeStartedProvider = ChangeNotifierProvider((ref) {
  return HomeScreenProvider();
},);

class HomeScreenProvider with ChangeNotifier{

bool _isTimeStarted = true;
bool get isTimeStarted => _isTimeStarted;

void toggleIsStarted(){
  _isTimeStarted = !_isTimeStarted;
  notifyListeners();
}
}