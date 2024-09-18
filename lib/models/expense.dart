import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 2)
class Expense {
  Expense({
    required this.id,
    required this.amount,
    required this.date,
    required this.note,
    required this.category,
  });
  

  @HiveField(0)
  String id;

  @HiveField(1)
  int amount;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String note;

  @HiveField(4)
  String category;
}