// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itens_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ItemStore on ItemStoreBase, Store {
  late final _$itemsAtom = Atom(name: 'ItemStoreBase.items', context: context);

  @override
  List<ItemModel> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(List<ItemModel> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$ItemStoreBaseActionController =
      ActionController(name: 'ItemStoreBase', context: context);

  @override
  void add(ItemModel item) {
    final _$actionInfo =
        _$ItemStoreBaseActionController.startAction(name: 'ItemStoreBase.add');
    try {
      return super.add(item);
    } finally {
      _$ItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(ItemModel item) {
    final _$actionInfo = _$ItemStoreBaseActionController.startAction(
        name: 'ItemStoreBase.remove');
    try {
      return super.remove(item);
    } finally {
      _$ItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update(ItemModel item) {
    final _$actionInfo = _$ItemStoreBaseActionController.startAction(
        name: 'ItemStoreBase.update');
    try {
      return super.update(item);
    } finally {
      _$ItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setItems(List<ItemModel> items) {
    final _$actionInfo = _$ItemStoreBaseActionController.startAction(
        name: 'ItemStoreBase.setItems');
    try {
      return super.setItems(items);
    } finally {
      _$ItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items}
    ''';
  }
}
