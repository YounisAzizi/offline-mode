import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:offline_mode/const/const.dart';
import 'package:offline_mode/providers/data/user_local_store_provider.dart';
import 'package:offline_mode/repositories/notification_repository.dart';
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
    final users = ref.watch(userLocalStoreProvider).users;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  Duration difference = Duration.zero;
                  if (user.endTime.isNotEmpty && user.startTime.isNotEmpty) {
                    final startTime = DateTime.parse(user.startTime);
                    final endTime = DateTime.parse(user.endTime);
                    difference = endTime.difference(startTime);
                  }
                  return ListTile(
                    title: Text('${user.name} ${user.lastName}'),
                    subtitle: Text(
                      'Start Time: ${user.startTime}\nEnd Time: ${user.endTime}'
                      '\nDeference: ${difference.inHours}:${difference.inMinutes}:${difference.inSeconds}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    trailing: Icon(
                      !user.isStarted ? Icons.check_circle : Icons.cancel,
                      color: !user.isStarted ? Colors.green : Colors.red,
                    ),
                  );
                },
              ),
            ),
            ButtonWidget(
              text: isStarted ? 'Start Time' : 'End Time',
              onPressed: () async {
                if (!isInternetConnected) {
                  debugPrint('Internet is connected');
                } else {
                  if (isStarted) {
                    await ref
                        .read(userLocalStoreProvider.notifier)
                        .insertUser(defaultUserModel);
                   await NotificationService().zonedScheduleNotification(
                        title: 'Younis',
                        body: 'its passed 1 minute from your startTime',
                        startTime:  const Duration(minutes: 1),
                        id: 2
                    );
                  } else {
                    await ref
                        .read(userLocalStoreProvider.notifier)
                        .updateUserEndTime(currentUserId, DateTime.now());
                  }
                  ref.read(isTimeStartedProvider.notifier).toggleIsStarted();
                }
              },
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
