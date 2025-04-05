import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartBox extends StatelessWidget {
  final String name;
  final String price;
  final int quantity;
  final String imagePath;
  final VoidCallback? onRemove;

  const CartBox({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imagePath,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              imagePath,
              width: 90,
              height: 80,
              fit: BoxFit.fill,
            ),
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('₹ $price', style: const TextStyle(fontSize: 16)),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              children: [
                IconButton(onPressed: onRemove, icon: const Icon(Icons.close)),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Qty: ",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      TextSpan(
                        text: quantity.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
