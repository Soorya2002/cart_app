import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductBox extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;
  final VoidCallback? onPressed;
  const ProductBox({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              height: 140,
              width: 180,
              fit: BoxFit.cover,
            ),
          ),
          Gap(10),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(10),
              Text("₹$price", style: TextStyle(fontSize: 16)),
            ],
          ),
          Gap(10),
          OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue,
              side: BorderSide(color: Colors.blue),
              // padding: EdgeInsets.symmetric(horizontal: 55, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Add to Cart', style: TextStyle(color: Colors.blue)),
          ),
          Gap(10),
        ],
      ),
    );
  }
}
