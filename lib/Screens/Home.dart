// lib/View/HomeScreen/home_screen.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internship_task/Resources/Widgets/CustomText.dart';
import 'package:internship_task/Resources/utils/Appcolors.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final pageControllerProvider = Provider<PageController>((ref) {
  final selectedIndex = ref.watch(selectedIndexProvider);
  return PageController(initialPage: selectedIndex);
});

final categoriesProvider = Provider<List<Map<String, String>>>(
  (ref) => [
    {
      'label': 'Burger',
      'image': 'assets/burger.png',
      'description': 'Juicy grilled beef burger delight',
      'Price': '5',
    },
    {
      'label': 'Pizza',
      'image': 'assets/pizza.png',
      'description': 'Cheesy pepperoni loaded pizza slice',
      'Price': '10',
    },
    {
      'label': 'Dessert',
      'image': 'assets/dessert.png',
      'description': 'Sweet creamy chocolate dessert treat',
      'Price': '11',
    },
    {
      'label': 'Ramen',
      'image': 'assets/ramen.png',
      'description': 'Hot spicy ramen noodle bowl',
      'Price': '20',
    },
  ],
);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaquery = MediaQuery.sizeOf(context);

    log("message");

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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Online Food",
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Appcolors.yellow,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          "assets/Cart icon.svg",
                          height: 26,
                          width: 26,
                          color: Appcolors.Black,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Delivery!",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search Your Fav Food",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 160,
                  child: Consumer(
                    builder: (context, ref, Child) {
                      final selectedIndex = ref.watch(selectedIndexProvider);
                      final categories = ref.watch(categoriesProvider);
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected = selectedIndex == index;

                          return Consumer(
                            builder: (context, ref, Child) {
                              final pageController = ref.watch(
                                pageControllerProvider,
                              );
                              return GestureDetector(
                                onTap: () {
                                  ref
                                          .read(selectedIndexProvider.notifier)
                                          .state =
                                      index;
                                  pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.yellow[700]
                                            : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          category['image']!,
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(category['label']!),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Appcolors.yellow,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Appcolors.Black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(height: mediaquery.height * 0.46),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: mediaquery.height * 0.4,
                        width: mediaquery.width,
                        decoration: BoxDecoration(
                          color: Appcolors.White,
                          boxShadow: [
                            BoxShadow(
                              color: Appcolors.Black.withOpacity(0.2),
                              blurRadius: 10,
                            ),
                          ],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            children: [
                              Container(
                                height: mediaquery.height * 0.24,
                                decoration: BoxDecoration(
                                  color: Appcolors.yellow,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: mediaquery.height * 0.02,
                      ),
                      child: SizedBox(
                        height: mediaquery.height * 0.5,
                        child: Consumer(
                          builder: (context, ref, Child) {
                            final pageController = ref.watch(
                              pageControllerProvider,
                            );
                            final categories = ref.watch(categoriesProvider);
                            return PageView.builder(
                              controller: pageController,
                              itemCount: categories.length,
                              onPageChanged: (index) {
                                ref.read(selectedIndexProvider.notifier).state =
                                    index;
                              },
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        category["image"]!,
                                        fit: BoxFit.contain,
                                        height: 260,
                                        width: 280,
                                      ),
                                    ),
                                    SizedBox(height: mediaquery.height * 0.05),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: mediaquery.width * 0.04,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: category["label"]!,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          CustomText(
                                            text: "\$${category["Price"]}",
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: mediaquery.width * 0.04,
                                      ),
                                      child: CustomText(
                                        text: category["description"]!,
                                        color: Colors.black87,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 40,

                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                backgroundColor:
                                                    Appcolors.yellow,
                                                foregroundColor: Colors.white,
                                              ),
                                              onPressed: () {},
                                              child: CustomText(
                                                text: "Add to Card",
                                                color: Appcolors.Black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
