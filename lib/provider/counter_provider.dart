import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<double>((ref) {
  return 0;
});
