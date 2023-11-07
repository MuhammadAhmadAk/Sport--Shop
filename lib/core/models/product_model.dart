class  ProductModel {
  String? id;
  String? name;
  double? price;
  String? description;
  String? category;
  String? imageUrl;

   ProductModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.category,
    this.imageUrl,
  });

  factory  ProductModel.fromMap(Map<String, dynamic> map) {
    return  ProductModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      category: map['category'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}
