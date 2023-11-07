class CartModel {
  final String? productId;
  final String? productName;
  final String? price;
  final int? quantity;
  bool isSelected; // Property to track selection state
  final String? imageUrl;

  CartModel( {
    this.productId,
    this.productName,
    this.price,
    this.quantity,
    this.isSelected = false, // Initialize isSelected as false by default
    this.imageUrl,
  });

  // Convert a Map to a CartModel object
  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      price: map['price'],
      quantity: map['quantity'] as int,
      isSelected:
          map['isSelected'] ?? false,
      imageUrl: map['imageUrl']
       // Initialize isSelected from Firestore
    );
  }

  // Convert a CartModel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'isSelected': isSelected, // Include isSelected in the map
      'imageUrl':imageUrl
    };
  }

  // Add a copyWith method to create a new instance with updated values
  CartModel copyWith({
    String? productId,
    String? productName,
    String? price,
    int? quantity,
    bool? isSelected,
    String? imageUrl
  }) {
    return CartModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
      imageUrl: imageUrl??this.imageUrl
    );
  }
}
