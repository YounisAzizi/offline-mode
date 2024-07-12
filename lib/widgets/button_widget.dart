import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonWidget extends ConsumerWidget {
  final String text;
  final void Function()? onPressed;
  const ButtonWidget({super.key,required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        fixedSize: const Size(200, 200)
      ),
      onPressed: onPressed,
      child:  Text(text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),),
    );
  }
}
