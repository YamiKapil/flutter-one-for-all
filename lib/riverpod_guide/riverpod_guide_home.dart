import 'package:flutter/material.dart';
import 'package:one_for_all/common_components/navigation_button.dart';
import 'package:one_for_all/riverpod_guide/riverpod_screens/provider_page.dart';

import 'riverpod_screens/change_notifier_provider_page.dart';
import 'riverpod_screens/future_provider_page.dart';
import 'riverpod_screens/state_notifier_provider_page.dart';
import 'riverpod_screens/state_provider_page.dart';
import 'riverpod_screens/stream_provider_page.dart';

class RiverpodGuideHome extends StatelessWidget {
  const RiverpodGuideHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Guide'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProviderPage(),
                ),
              ),
              child: const Text('Provider Page'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StateProviderPage(),
                ),
              ),
              child: const Text('State Provider Page'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FutureProviderPage(),
                ),
              ),
              child: const Text('Future Provider Page'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StreamProviderPage(),
                ),
              ),
              child: const Text('Stream Provider Page'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChangeNotifierProviderPage(),
                ),
              ),
              child: const Text('Change Notifier Provider Page'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StateNotifierProviderPage(),
                ),
              ),
              child: const Text('State Notifier Provider Page'),
            ),
          ],
        ),
      ),
    );
  }
}
