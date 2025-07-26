// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItem {
  final String id;
  final String itemName;
  final String description;
  final double price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.itemName,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory CartItem.fromMap(String id, Map<String, dynamic> map) {
    return CartItem(
      id: id,
      itemName: map['itemName'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  @override
  String toString() {
    return 'CartItem(id: $id, itemName: $itemName, description: $description, price: $price, imageUrl: $imageUrl)';
  }
}
