import 'package:flutter/material.dart';
import 'package:goodbye_money/models/boxes.dart';
import 'package:goodbye_money/models/category.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/tabs.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseCategoryAdapter());
  categoryBox = await Hive.openBox<ExpenseCategory>('categoryBox');
  Hive.registerAdapter(ExpenseAdapter());
  expenseBox = await Hive.openBox<Expense>('expenseBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const TabsController(),
    );
  }
}
