import 'package:cart_app/features/cart/models/product_model.dart';
import 'package:cart_app/features/cart/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    // ✅ FIXED: Properly checks all cart items, not just the first
    final isInCart = productProvider.cart.any(
      (cart) =>
          cart.items?.any((item) => item.productId == widget.product.id) ??
          false,
    );

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.asset('assets/wall_decor.jpg'),
          Gap(20),
          Row(
            children: [
              Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name ?? "",
                    style: TextStyle(fontSize: 30, color: Colors.blue),
                  ),
                  Gap(10),
                  Text(
                    '₹ ${widget.product.price}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(),
              isInCart
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
                    child: Text(
                      'View in Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                  : OutlinedButton(
                    onPressed: () {
                      context.read<ProductProvider>().addCart(
                        productId: widget.product.id ?? "",
                      );
                      // No need to call setState if you're already using Provider
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
              Gap(10),
            ],
          ),
        ],
      ),
    );
  }
}
