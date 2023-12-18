import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_for_all/riverpod_guide/riverpod_service/stream_service.dart';

final streamProvider = StreamProvider.autoDispose((ref) {
  final streamService = ref.watch(streamServiceProvider);
  return streamService.getStream();
});

class StreamProviderPage extends ConsumerWidget {
  const StreamProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueStream = ref.watch(streamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider Page'),
      ),
      body: Center(
        child: valueStream.when(
          data: (data) {
            return Text(
              data.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
          error: (error, _) {
            return Text(
              error.toString(),
            );
          },
          loading: () {
            return const CircularProgressIndicator.adaptive();
          },
        ),
      ),
    );
  }
}
