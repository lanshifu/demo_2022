import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamProvider = StreamProvider<int>((ref) {
  return Stream.fromIterable([1, 2, 3]);
}, name: "streamProvider");
