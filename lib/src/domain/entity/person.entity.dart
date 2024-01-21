import 'package:flutter/material.dart';

typedef RemovedItemBuilder = Widget Function(int item, BuildContext context, Animation<double> animation);

class PersonEntity<E> {
  PersonEntity({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<SliverAnimatedGridState> listKey;
  final RemovedItemBuilder removedItemBuilder;
  final List<E> _items;

  SliverAnimatedGridState get _animatedGrid => listKey.currentState!;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedGrid.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedGrid.removeItem(
        index,
        (BuildContext context, Animation<double> animation) => removedItemBuilder(index, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
