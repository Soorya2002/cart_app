import 'package:cart_app/core/utils/storage_services.dart';
import 'package:cart_app/features/cart/provider/product_provider.dart';
import 'package:cart_app/features/cart/widgets/cart_box.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = context.read<ProductProvider>();
    productProvider.viewCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Gap(30),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.blue, size: 30),
                  ),
                  Gap(75),
                  Text(
                    'My Cart',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () async {
                      await StorageServices().logout();
                      // ignore: use_build_context_synchronously
                      context.go('/login');
                    },
                    icon: Icon(Icons.logout, color: Colors.blue, size: 30),
                  ),
                ],
              ),
              Gap(20),
              Consumer<ProductProvider>(
                builder: (context, value, child) {
                  // Check if cart is empty or null
                  if (value.cart.isEmpty ||
                      value.cart[0].items == null ||
                      value.cart[0].items!.isEmpty) {
                    return Text(
                      "Your cart is empty",
                      style: TextStyle(fontSize: 18),
                    );
                  }

                  return SizedBox(
                    height:
                        MediaQuery.of(context).size.height *
                        0.6, // Adjust height
                    child: ListView.builder(
                      itemCount: value.cart[0].items!.length,
                      itemBuilder: (context, index) {
                        final item = value.cart[0].items![index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: CartBox(
                            imagePath: 'assets/wall_decor.jpg',
                            name: item.name ?? "",
                            price: item.price ?? "",
                            quantity: item.quantity ?? 0,
                            onRemove: () {
                              context.read<ProductProvider>().removeCartItem(
                                productId: item.productId ?? "",
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
