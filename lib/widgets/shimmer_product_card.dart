import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
              )),
              const SizedBox(height: 12),
              Container(
                height: 16,
                width: 120,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Container(
                height: 14,
                width: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Container(
                height: 18,
                width: 60,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
