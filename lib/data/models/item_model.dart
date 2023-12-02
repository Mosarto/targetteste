class ItemModel {
  int? id;
  String titulo;

  ItemModel({
    required this.titulo,
    this.id,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      titulo: json['titulo'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'id': id,
    };
  }
}
