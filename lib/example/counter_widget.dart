import 'package:demo_2022/example/provider/clockStateNotifierProvider.dart';
import 'package:demo_2022/example/provider/counterStateProvider.dart';
import 'package:demo_2022/example/provider/familyProvider.dart';
import 'package:demo_2022/example/provider/futureProvider.dart';
import 'package:demo_2022/example/provider/streamProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class CounterWidget extends ConsumerWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<StateController<int>>(counterProvider.state,
        (previous, current) {
      print('Value is ${current.state}');
    });
    final streamAsyncValue = ref.watch(streamProvider);
    final futureAsyncValue = ref.watch(futureProvider);
    print('CounterWidget build');
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ref.read(counterProvider.notifier).state++;
          },
          child: Text(
              "StateProvider:点击 ${ref.read(counterProvider.notifier).state}"),
        ),
        Text("counter ${ref.read(counterProvider.notifier).state}"),
        Text("StateNotifierProvider: ${ref.watch(clockStateNotifierProvider)}"),
        Column(
          children: [
            const Text("StreamProvider"),
            streamAsyncValue.when(
              data: (value) => Text("data:$value"),
              loading: () => CircularProgressIndicator(),
              error: (e, st) => Text('Error: $e'),
            ),
          ],
        ),
        Column(
          children: [
            const Text("futureAsyncValue"),
            futureAsyncValue.when(
              data: (value) => Text("data:$value"),
              loading: () => CircularProgressIndicator(),
              error: (e, st) => Text('Error: $e'),
            ),
          ],
        ),
        Column(
          children: [
            Text("familyStateProvider:${ref.read(familyStateProvider(10))}"),
          ],
        ),
      ],
    );
  }
}
