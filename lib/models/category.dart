import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class ExpenseCategory {
  
  ExpenseCategory({
    required this.name,
    required this.colorValue
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  int colorValue;

  Color get color => Color(colorValue);
  set color(Color value) => colorValue = value.value;
}