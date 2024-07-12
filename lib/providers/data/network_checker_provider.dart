import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final networkCheckerProvider = ChangeNotifierProvider(
  (ref) => NetworkCheckerNotifier(),
);


class NetworkCheckerNotifier extends ChangeNotifier {

  final InternetConnection _internetConnection = InternetConnection();

  StreamSubscription? _internetConnectionStreamSubscription;


  bool _isConnected = false;
  bool get isConnected => _isConnected;



  NetworkCheckerNotifier() {
    networkListener();
  }

  void networkListener() {
   _internetConnectionStreamSubscription =
       _internetConnection.onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          _isConnected = true;
          break;
        case InternetStatus.disconnected:
          _isConnected = false;
          break;
        default:
          _isConnected = false;
          break;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }
}
