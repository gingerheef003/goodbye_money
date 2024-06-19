import 'package:flutter/material.dart';
import 'package:goodbye_money/types/widget.dart';

class Expenses extends WidgetWithTitle {
  const Expenses({super.key}) : super(title: "Expenses");


  @override
  Widget build(BuildContext context) {
    return const Text("Expenses");
  }
}