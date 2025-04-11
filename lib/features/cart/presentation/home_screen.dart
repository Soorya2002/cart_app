import 'package:cart_app/features/cart/provider/product_provider.dart';
import 'package:cart_app/features/cart/widgets/product_box.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = context.read<ProductProvider>();
    productProvider.fetchProducts();
    productProvider.viewCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(30),
            Row(
              children: [
                const Text(
                  'Products',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    context.pushNamed('cart');
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ],
            ),
            const Gap(20),

            /// Grid View
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return _buildShimmerEffect();
                  }

                  if (value.product.isEmpty) {
                    return const Center(
                      child: Text(
                        "No products found!",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 10),
                    itemCount: value.product.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.63,
                        ),
                    itemBuilder: (context, index) {
                      final product = value.product[index];
                      final isInCart = product.alreadyInCart ?? false;

                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            'productDetail',
                            pathParameters: {'id': product.id ?? ''},
                          );
                        },
                        child: ProductBox(
                          name: product.name ?? "",
                          price: product.price ?? "",
                          imagePath: 'assets/wall_decor.jpg',
                          isInCart: isInCart,
                          onPressed: () {
                            if (!isInCart) {
                              context.read<ProductProvider>().addCart(
                                productId: product.id ?? "",
                              );
                            } else {
                              context.pushNamed('cart');
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shimmer effect for loading state
  Widget _buildShimmerEffect() {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 10),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.63,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const Gap(10),
                Container(height: 16, width: 80, color: Colors.grey[300]),
                const Gap(10),
                Container(height: 16, width: 50, color: Colors.grey[300]),
                const Gap(10),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
