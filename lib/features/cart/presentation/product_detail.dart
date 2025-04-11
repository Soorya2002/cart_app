import 'package:cart_app/features/cart/models/product_model.dart';
import 'package:cart_app/features/cart/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    final products = productProvider.product;

    // Safely find the product
    final product = products.firstWhere(
      (p) => p.id == productId,
      orElse: () => ProductModel(id: "", name: "Unknown", price: ''),
    );

    // If product wasn't found, show a fallback
    if (product.id == "") {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text("Product not found")),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.asset('assets/wall_decor.jpg'),
          const Gap(20),
          Row(
            children: [
              const Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? "",
                    style: const TextStyle(fontSize: 30, color: Colors.blue),
                  ),
                  const Gap(10),
                  Text(
                    '₹ ${product.price}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              product.alreadyInCart == true
                  ? ElevatedButton(
                    onPressed: () {
                      context.pushNamed('cart');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'View in Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                  : OutlinedButton(
                    onPressed: () {
                      context.read<ProductProvider>().addCart(
                        productId: product.id ?? "",
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
              const Gap(10),
            ],
          ),
        ],
      ),
    );
  }
}
