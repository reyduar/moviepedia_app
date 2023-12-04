import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    const messages = <String>[
      'Loading...',
      'Still loading...',
      'Almost there...',
      'Loading failed...',
      'Just kiding...',
      'Everythin is good...',
      'Still working...',
    ];
    return Stream.periodic(const Duration(milliseconds: 1200),
        (step) => messages[step % messages.length]).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Please wait...'),
        const SizedBox(
          height: 10,
        ),
        const CircularProgressIndicator(
          strokeWidth: 2,
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: getLoadingMessages(),
          builder: (context, snapshot) {
            return Text(snapshot.data ?? '');
          },
        )
      ],
    ));
  }
}
