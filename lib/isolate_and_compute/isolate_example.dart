import 'package:flutter/material.dart';

class IsolateExample extends StatefulWidget {
  const IsolateExample({super.key});

  @override
  State<IsolateExample> createState() => _IsolateExampleState();
}

class _IsolateExampleState extends State<IsolateExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate Example'),
      ),
    );
  }
}
