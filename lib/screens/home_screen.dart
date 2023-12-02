import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:target/data/models/item_model.dart';
import 'package:target/data/providers/item_provider.dart';
import 'package:target/data/providers/itens_mobx.dart';
import 'package:target/utils/validators.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  final List<ItemModel> items;
  const HomeScreen({super.key, required this.items});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late FocusNode _tituloFocusNode;
  late TextEditingController _tituloController;

  final ItemStore itemStore = ItemStore();

  @override
  void initState() {
    _tituloController = TextEditingController();
    _tituloFocusNode = FocusNode();
    itemStore.setItems(widget.items);
    super.initState();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _tituloFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.all(42),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
            colors: [
              Color(0xff1e5365),
              Color(0xff6fb0ae),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Observer(
                    builder: (_) {
                      if (itemStore.items.isEmpty) {
                        return const Center(
                          child: Text('Nenhum item cadastrado'),
                        );
                      }
                      return ListView.builder(
                        itemCount: itemStore.items.length,
                        itemBuilder: (context, index) {
                          ItemModel item = itemStore.items[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  item.titulo,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              TextEditingController
                                                  tituloController =
                                                  TextEditingController(
                                                text: item.titulo,
                                              );
                                              GlobalKey<FormState>
                                                  formKeyDialog =
                                                  GlobalKey<FormState>();
                                              return AlertDialog(
                                                title:
                                                    const Text('Editar item'),
                                                content: Form(
                                                  key: formKeyDialog,
                                                  child: TextFormField(
                                                    controller:
                                                        tituloController,
                                                    validator: tituloValidator,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          'Digite seu texto',
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      errorStyle: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _tituloFocusNode
                                                          .requestFocus();
                                                    },
                                                    child:
                                                        const Text('Cancelar'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      if (formKeyDialog
                                                          .currentState!
                                                          .validate()) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        item.titulo =
                                                            tituloController
                                                                .text;
                                                        await updateItem(item);
                                                        itemStore.update(item);
                                                        _tituloFocusNode
                                                            .requestFocus();
                                                      }
                                                    },
                                                    child: const Text('Salvar'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit_rounded,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Excluir item'),
                                              content: const Text(
                                                'Deseja realmente excluir o item?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    _tituloFocusNode
                                                        .requestFocus();
                                                  },
                                                  child: const Text('Não'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    itemStore.remove(item);
                                                    await removeItem(item);
                                                    _tituloFocusNode
                                                        .requestFocus();
                                                  },
                                                  child: const Text('Sim'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete_rounded,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      );
                    },
                  )),
              const SizedBox(height: 28),
              Form(
                key: _formKey,
                child: TextFormField(
                  autofocus: true,
                  focusNode: _tituloFocusNode,
                  controller: _tituloController,
                  validator: tituloValidator,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Digite seu texto',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                  onFieldSubmitted: (value) async {
                    if (_formKey.currentState!.validate()) {
                      ItemModel item = ItemModel(
                        titulo: value,
                      );
                      await addItem(item);
                      itemStore.add(item);
                      _tituloController.clear();
                    } else {
                      _tituloFocusNode.requestFocus();
                    }
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              TextButton(
                onPressed: () async {
                  if (!await launchUrl(
                    Uri.parse('https://www.google.com.br'),
                  )) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Não foi possível abrir o link'),
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Política de privacidade',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
