import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class ExpenseCategory extends HiveObject {
  
  ExpenseCategory({
    required this.name,
    required this.colorValue,
    this.visible = true
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  int colorValue;

  @HiveField(2, defaultValue: true)
  bool visible;

  Color get color => Color(colorValue);
  set color(Color value) => colorValue = value.value;
}