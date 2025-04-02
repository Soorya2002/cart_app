import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartBox extends StatelessWidget {
  const CartBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),

            child: Image.asset(
              'assets/wall_decor.jpg',
              width: 90,
              height: 80,
              fit: BoxFit.fill,
            ),
          ),
          Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wall Decor',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('₹ 250', style: TextStyle(fontSize: 16)),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Qty: ",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      TextSpan(
                        text: "2",
                        style: TextStyle(
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
