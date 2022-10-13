import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final clockStateNotifierProvider =
    StateNotifierProvider<ClockNotifier, DateTime>((ref) {
  return ClockNotifier();
}, name: "clockStateNotifierProvider");

class ClockNotifier extends StateNotifier<DateTime> {
  late final Timer _timer;

  ClockNotifier() : super(DateTime.now()) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = DateTime.now();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
