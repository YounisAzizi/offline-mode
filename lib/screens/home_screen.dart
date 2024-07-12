import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:offline_mode/const/const.dart';
import 'package:offline_mode/providers/data/user_local_store_provider.dart';
import 'package:offline_mode/widgets/button_widget.dart';
import '../models/user_model.dart';
import '../providers/data/network_checker_provider.dart';
import '../providers/screen/home_screen_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isStarted = ref.watch(isTimeStartedProvider).isTimeStarted;
    final isInternetConnected = ref.watch(networkCheckerProvider).isConnected;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonWidget(
              text: isStarted ? 'Start Time' : 'End Time',
              onPressed: () async {
                if(isInternetConnected){
                  print('Internet is connected');
                }else{
                  if (isStarted) {
                    await ref
                        .read(userLocalStoreProvider.notifier)
                        .insertUser(defaultUserModel);
                  }
                  else {
                    await ref
                        .read(userLocalStoreProvider.notifier)
                        .updateUserEndTime(currentUserId, DateTime.now());
                  }
                  final users = ref.watch(userLocalStoreProvider).users;
                  for (var e in users) {
                    print('id: ${e.id}');
                    print('name: ${e.name}');
                    print('last name: ${e.lastName}');
                    print('start time: ${e.startTime}');
                    print('end time: ${e.endTime}');
                  }
                  print(users.length);

                  ref.read(isTimeStartedProvider.notifier).toggleIsStarted();
                }

              },
            ),
          ],
        ),
      ),
    );
  }
}
