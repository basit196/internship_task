// Your imports remain unchanged, add these:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:internship_task/Proivders/HomeProvider.dart';
import 'package:internship_task/Resources/Widgets/CustomText.dart';
import 'package:internship_task/Resources/utils/Appcolors.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaquery = MediaQuery.sizeOf(context);
    final cartItemsAsync = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔙 Back Button
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    GoRouter.of(context).pop();
               
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Appcolors.White,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Appcolors.Black.withOpacity(0.4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        "assets/arrowicon.svg",
                        height: 26,
                        width: 26,
                        color: Appcolors.Black,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Center(
                  child: CustomText(
                    text: "My Order",
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: CustomText(
                    textAlign: TextAlign.center,
                    text:
                        "Reference site about Loren Snips information to tis rugger made by  a talk show based ",
                    fontSize: 12.sp,
                  ),
                ),

                /// 🔁 Cart Items from Firestore
                cartItemsAsync.when(
                  data: (data) {
                    if (data.docs.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: CustomText(
                            text: "Your cart is empty!",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    // Calculate totals
                    double itemTotal = 0;
                    for (var doc in data.docs) {
                      final cartItem = doc.data();
                      final price = cartItem['price'] as num;
                      final quantity = cartItem['quantity'] ?? 1;
                      itemTotal += price * quantity;
                    }

                    const double deliveryCharges = 5.00;
                    const double taxRate = 0.05; // 5% tax
                    double tax = itemTotal * taxRate;
                    double grandTotal = itemTotal + deliveryCharges + tax;

                    return Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final cartItem = data.docs[index].data();
                            final itemName = cartItem['itemName'];
                            final price = cartItem['price'];
                            final imageUrl = cartItem['imageUrl'];
                            final quantity = cartItem['quantity'] ?? 1;

                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: mediaquery.height * 0.1,
                                          width: mediaquery.width * 0.32,
                                          decoration: BoxDecoration(
                                            color: Appcolors.White,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Appcolors
                                                    .Black.withOpacity(0.2),
                                                blurRadius: 10,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6),
                                            child: Container(
                                              height: mediaquery.height * 0.08,
                                              width: mediaquery.width * 0.3,
                                              decoration: BoxDecoration(
                                                color: Appcolors.yellow,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: mediaquery.height * 0.04,
                                          ),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.contain,
                                            height: 140,
                                            width: 160,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          textAlign: TextAlign.center,
                                          text: itemName,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 14,
                                              backgroundColor: Appcolors.yellow,
                                              child: Icon(
                                                Icons.remove,
                                                color: Appcolors.Black,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8.0,
                                                  ),
                                              child: CustomText(
                                                text: "$quantity",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Appcolors.Black,
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 14,
                                              backgroundColor: Appcolors.yellow,
                                              child: Icon(
                                                Icons.add,
                                                color: Appcolors.Black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    CustomText(
                                      text:
                                          "\$${(price * quantity).toStringAsFixed(2)}",
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                Divider(color: Appcolors.Black, thickness: 1),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 5),
                        buildTotalRow(
                          "Item Total",
                          "\$${itemTotal.toStringAsFixed(2)}",
                        ),
                        buildTotalRow(
                          "Delivery Charges",
                          "\$${deliveryCharges.toStringAsFixed(2)}",
                        ),
                        buildTotalRow("Tax", "\$${tax.toStringAsFixed(2)}"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Total",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Appcolors.Black,
                              ),
                              CustomText(
                                text: "\$${grandTotal.toStringAsFixed(2)}",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Appcolors.Black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(
                    child: CustomText(
                      text: 'Failed to load cart: $err',
                      fontSize: 14.sp,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTotalRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black45,
          ),
          CustomText(
            text: value,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
