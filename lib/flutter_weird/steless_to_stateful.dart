import 'package:flutter/material.dart';

class StateLessToStateFul extends StatelessWidget {
  StateLessToStateFul({super.key});

  late final element = StatelessElement(this);
  var counter = 0;

  @override
  StatelessElement createElement() => element;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless to Stateful'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                counter++;
                element.markNeedsBuild();
              },
              child: const Text('Click Me'),
            ),
            const SizedBox(height: 50),
            Text('$counter')
          ],
        ),
      ),
    );
  }
}
