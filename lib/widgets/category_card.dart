import 'package:flutter/material.dart';
import 'package:shopping_cart_app/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFEEEEEE),
            child: Icon(
              category.icon,
              color: Colors.black,
              size: 30,
            ),
          ),
          const SizedBox(height: 10),
          Text(category.name),
        ],
      ),
    );
  }
}
