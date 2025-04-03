import 'package:cart_app/core/utils/storage_services.dart';
import 'package:cart_app/features/cart/widgets/cart_box.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: CartBox(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
