import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

///family，可以传参
final familyStateProvider =
    StateProvider.autoDispose.family<int, int>((ref, offset) {
  return offset;
});

// some model class
class Item {
  Item(this.id, this.name);
  final String id;
  final String name;
/* many other properties here */
}

class Database {
  Stream<Item> itemStream(String itemId) {
    return Stream.value(Item(itemId, itemId));
  }
}

final databaseProvider = Provider<Database>((ref) => Database());

// 1. add an itemId argument with a family modifier
final itemStreamProvider =
    StreamProvider.autoDispose.family<Item, String>((ref, itemId) {
  // 2. retrieve the database with ref.watch()
  final database = ref.watch(databaseProvider);
  // 3. pass the itemId to the database method and return the output stream
  return database.itemStream(itemId);
});
