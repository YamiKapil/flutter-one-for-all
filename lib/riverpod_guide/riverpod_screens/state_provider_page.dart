import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final valueStateProvider = StateProvider.autoDispose<int>((ref) => 22);

class StateProviderPage extends ConsumerWidget {
  const StateProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(valueStateProvider);
    ref.listen<int>(
      valueStateProvider,
      (prev, curr) {
        // log('StateProviderPage: $prev-> $curr');
        if (curr == 30) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The value reached 30'),
            ),
          );
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'the value is $value',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(valueStateProvider.notifier).state++;
              },
              child: const Text('Increment by 1'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(valueStateProvider.notifier).state--;
              },
              child: const Text('Decrease by 1'),
            ),
            // reset back to the origin value
            ElevatedButton(
              onPressed: () {
                ref.invalidate(valueStateProvider);
              },
              child: const Text('Invalidate'),
            ),
          ],
        ),
      ),
    );
  }
}
