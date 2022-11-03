import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_for_all/riverpod_guide/riverpod_model/suggestion_model.dart';
import 'package:one_for_all/riverpod_guide/riverpod_service/api_service.dart';

final suggestionFutureProvider =
    FutureProvider.autoDispose<Suggestion>((ref) async {
    // when passing data (parameter)...
    // FutureProvider.autoDispose.family<Suggestion, String>((ref, id) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getSuggestion();
  // when passing data..
  // return apiService.getSuggestion(id);
});

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestionRef = ref.watch(suggestionFutureProvider);
    // when passing parameters..
    // final suggestionRef = ref.watch(suggestionFutureProvider('1'));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider Page'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(suggestionFutureProvider.future),
        child: ListView(
          children: [
            suggestionRef.when(
              data: (data) {
                return Text(
                  data.activity,
                  style: Theme.of(context).textTheme.headline4,
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
          ],
        ),
      ),
    );
  }
}
