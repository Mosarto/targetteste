import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target/data/models/item_model.dart';

Future<void> addItem(ItemModel item) async {
  final prefs = await SharedPreferences.getInstance();
  final items = prefs.getStringList('items') ?? <String>[];
  final id = prefs.getInt('id') ?? 0;
  item.id = id;
  items.add(jsonEncode(item.toJson()));
  await prefs.setStringList('items', items);
}

Future<List<ItemModel>> getItems() async {
  final prefs = await SharedPreferences.getInstance();
  final items = prefs.getStringList('items') ?? <String>[];
  if (items.isEmpty) {
    return [];
  }
  return items.map((e) => ItemModel.fromJson(jsonDecode(e))).toList();
}

Future<void> removeItem(ItemModel item) async {
  final prefs = await SharedPreferences.getInstance();
  final items = prefs.getStringList('items') ?? <String>[];
  items.remove(jsonEncode(item.toJson()));
  await prefs.setStringList('items', items);
}

Future<void> updateItem(ItemModel item) async {
  final prefs = await SharedPreferences.getInstance();
  final items = prefs.getStringList('items') ?? <String>[];
  items[item.id!] = jsonEncode(item.toJson());
  await prefs.setStringList('items', items);
}
