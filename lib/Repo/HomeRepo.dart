import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRepository {
  final FirebaseFirestore _firestore;

  HomeRepository(this._firestore);

  Future<List<Map<String, dynamic>>> getFoodItems() async {
    try {
      final snapshot = await _firestore.collection('Items').get();
      return snapshot.docs
          .map(
            (doc) => {
              'label': doc['label'],
              'image': doc['image'],
              'description': doc['description'],
              'Price': doc['price'].toString(),
            },
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to load food items: $e');
    }
  }

  Future<void> addToCart({
    required String userId,
    required String itemName,
    required String description,
    required double price,
    required String imageUrl,
  }) async {

      // 🔍 Check if item with same userId and itemName already exists
      final querySnapshot = await _firestore
          .collection('cart')
          .where('userId', isEqualTo: userId)
          .where('itemName', isEqualTo: itemName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // 🚫 Already in cart
        throw 'Already in cart';
      }

      // ✅ Add new item to cart
      await _firestore.collection('cart').add({
        'userId': userId,
        'itemName': itemName,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
    
  }
}
