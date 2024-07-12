import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user_model.dart';
import '../../repositories/database.dart';

final userLocalStoreProvider = ChangeNotifierProvider(
  (ref) => UserLocalStoreNotifier(),
);

class UserLocalStoreNotifier extends ChangeNotifier {

  DatabaseHelper databaseHelper = DatabaseHelper(tableName: 'users');

  List<UserModel> users = [];

  Future<void> insertUser(UserModel userModel) async {
    users.removeWhere((user) => user.id == userModel.id);
    await databaseHelper.insertUser(userModel);
    List<UserModel> user = await databaseHelper.getUsers();
    users.addAll(user);
    notifyListeners();
  }

  Future<void> updateUserEndTime(String userId, DateTime dateTime) async {
    await databaseHelper.updateUserEndTime(userId, dateTime);
    List<UserModel> user = await databaseHelper.getUsers();
    users.addAll(user);
    users.removeAt(user.length - 1);
    notifyListeners();
  }
}
