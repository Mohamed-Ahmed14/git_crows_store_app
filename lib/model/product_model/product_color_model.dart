import 'package:flutter/material.dart';
class ProductColorModel{
  String colorName;
  bool isSelected;
  Color? colorValue;
  ProductColorModel({
    required this.colorName,
    this.colorValue,
    this.isSelected = false,
  });
}