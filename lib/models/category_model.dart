import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String apiName;
  final IconData icon;

  CategoryModel({
    required this.name,
    required this.icon,
    required this.apiName,
  });
}
