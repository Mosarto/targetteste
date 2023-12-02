import 'package:mobx/mobx.dart';
import 'package:target/data/models/item_model.dart';

part 'itens_mobx.g.dart';

// ignore: prefer_final_fields
class ItemStore = ItemStoreBase with _$ItemStore;

abstract class ItemStoreBase with Store {
  @observable
  List<ItemModel> items = [];

  @action
  void add(ItemModel item) {
    items.add(item);
  }

  @action
  void remove(ItemModel item) {
    List<ItemModel> oldList = List.from(items);
    oldList.remove(item);
    items = oldList;
  }

  @action
  void update(ItemModel item) {
    items[item.id!] = item;
  }

  @action
  void setItems(List<ItemModel> items) {
    this.items = items;
  }
}
