import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:goodbye_money/models/boxes.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/types/widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Expenses extends WidgetWithTitle {
  const Expenses({super.key}) : super(title: "Expenses");

  @override
  Widget build(BuildContext context) {

    DateTime today = DateTime.now();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        // gradient: Gradient
      ),
      child: ValueListenableBuilder(
        valueListenable: expenseBox.listenable(),
        builder: (context, box, _) {
          List<Expense> expenseBoxRev = box.values.cast<Expense>().toList();
          expenseBoxRev.sort((a,b) => b.date.compareTo(a.date));
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Expense expense = expenseBoxRev[index];
                String date = DateUtils.isSameDay(expense.date, today)
                    ? "Today"
                    : DateUtils.isSameDay(
                            expense.date, today.subtract(const Duration(days: 1)))
                        ? "Yesterday"
                        : '${expense.date.day}/${expense.date.month}/${expense.date.year}';
                return Slidable(
                  key: Key(expense.id),
                  endActionPane: ActionPane(
                    extentRatio: 0.16,
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) => box.delete(expense.id),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.black,
                        icon: Icons.delete,
                      )
                    ],
                  ),
                  child: ListTile(
                    title: Text(expense.note),
                    subtitle: Text(expense.category),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('₹${expense.amount}', style: const TextStyle(fontSize: 18, color: Colors.red)),
                        const SizedBox(height:3),
                        Text(date),
                      ],
                    ),
                  ),
                );
              });
        }
      ),
    );
  }
}
