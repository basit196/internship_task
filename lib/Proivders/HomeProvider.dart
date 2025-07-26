import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internship_task/Models/CartItem.dart';
import 'package:internship_task/Repo/HomeRepo.dart';

//=====================================================//
//                HomeProvider
//=====================================================//
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final HomeRepositoryProvider = Provider<HomeRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return HomeRepository(firestore);
});

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final pageControllerProvider = Provider<PageController>((ref) {
  final selectedIndex = ref.watch(selectedIndexProvider);
  return PageController(initialPage: selectedIndex);
});

final categoriesProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final repository = ref.watch(HomeRepositoryProvider);
  return await repository.getFoodItems();
});

final addToCartProvider = Provider((ref) {
  final repo = ref.watch(HomeRepositoryProvider);
  return repo.addToCart;
});
//=====================================================//
//                HomeProvider
//=====================================================//

//=====================================================//
//                CartProvider
//=====================================================//

final cartProvider =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
      final user = FirebaseAuth.instance.currentUser;
      return FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: user?.uid)
          .snapshots();
    });

final firebaseUserIdProvider = Provider<String>((ref) {
  // You can replace this with more robust auth check
  return FirebaseAuth.instance.currentUser?.uid ?? '';
});
//=====================================================//
//                CartProvider               
//=====================================================//