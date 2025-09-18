class MyCollection {
  final int id;
  final int productId;
  final bool? isFav;
  final bool? isCart;
  MyCollection({
    required this.id,
    required this.productId,
    this.isFav,
    this.isCart,
  });

  factory MyCollection.fromJson(Map<String, dynamic> json) {
    return MyCollection(
      id: json['id'],
      productId: json['product_id'],
      isFav: json['isFav'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'product_id': productId, 'isFav': isFav};
  }
}
