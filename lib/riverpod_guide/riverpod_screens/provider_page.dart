import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final valueProvider = Provider<int>((ref) => 22);

// class ProviderPage extends StatelessWidget {
class ProviderPage extends ConsumerWidget {
  const ProviderPage({super.key});

  @override
  // Widget build(BuildContext context) {
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProviderHome'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        // one way to get the value of valueProvider is by using
        // consumer widget.

        // child: Consumer(
        //   builder: (context, ref, child) {
        //     return Center(
        //       child: Text(
        //         'The value is ${ref.watch(valueProvider)}',
        // style: Theme.of(context).textTheme.headline4,
        //       ),
        //     );
        //   },
        // ),

        // another way is extending class with ConsumerWidget and using
        // WidgetRef ref to interact with the providers.

        child: Center(
          child: Text(
            'The value is ${ref.watch(valueProvider)}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
