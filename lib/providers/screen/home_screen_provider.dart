import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/database.dart';

final isTimeStartedProvider = ChangeNotifierProvider<HomeScreenProvider>((ref) {
  return HomeScreenProvider();
});

class HomeScreenProvider with ChangeNotifier {
  bool _isTimeStarted = true;
  bool get isTimeStarted => _isTimeStarted;

  HomeScreenProvider() {
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    final dbHelper = DatabaseHelper(tableName: 'users');
    final users = await dbHelper.getUsers();
    if (users.isNotEmpty) {
      _isTimeStarted = !users.first.isStarted;
      notifyListeners();
    }
  }

  void toggleIsStarted() {
    _isTimeStarted = !_isTimeStarted;
    notifyListeners();
  }
}
