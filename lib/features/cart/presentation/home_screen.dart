import 'package:cart_app/features/cart/widgets/product_box.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(30),
            Row(
              children: [
                Text(
                  'Products',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    context.pushNamed('cart');
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ],
            ),
            Gap(20),

            /// Grid View with 2 Columns
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(bottom: 10),
                itemCount: 6, // Change this to the number of products
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12, // Horizontal spacing
                  mainAxisSpacing: 12, // Vertical spacing
                  childAspectRatio: 0.63, // Adjust height ratio
                ),
                itemBuilder: (context, index) {
                  return ProductBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
