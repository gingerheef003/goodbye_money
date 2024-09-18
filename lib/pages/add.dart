import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodbye_money/models/boxes.dart';
import 'package:goodbye_money/models/category.dart';
import 'package:goodbye_money/models/expense.dart';
import 'package:goodbye_money/pages/categories.dart';
import 'package:goodbye_money/types/widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class Add extends WidgetWithTitle {
  const Add({super.key}) : super(title: "Add");

  @override
  Widget build(BuildContext context) {
    return const AddContent();
  }
}

class AddContent extends StatefulWidget {
  const AddContent({super.key});

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  late TextEditingController _categoryController;


  // List<Category> categories = [];
  int _selectedCategoryIndex = 0;
  DateTime _selectedDate = DateTime.now();
  // bool get canSubmit => categories.isNotEmpty && _amountController.text.isNotEmpty;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void createExpense() {
    if(_amountController.text.isNotEmpty && _categoryController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      String id = uuid.v4();
      setState(() {
        expenseBox.put(id, Expense(
          id: id,
          amount: int.parse(_amountController.text),
          date: _selectedDate,
          category: _categoryController.text,
          note: _noteController.text
        ));
        _amountController.text = '';
        _noteController.text = '';
      });
    } else {
      const snack = SnackBar(
        content: Text('Enter all fields'),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
  }

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _noteController = TextEditingController();
    _categoryController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _noteController.dispose();
    _categoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                  // gradient: Gradient
                ),
                // padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: const Text('Amount'),
                      trailing: IntrinsicWidth(
                        child: TextField(
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          controller: _amountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                              hintText: 'Amount', border: InputBorder.none),
                        ),
                      ),
                    ),
                    ListTile(
                        title: const Text('Date'),
                        trailing: TextButton(
                            onPressed: () => selectDate(context),
                            child: Text(
                                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'))),
                    ListTile(
                        title: const Text('Category'),
                        trailing: ValueListenableBuilder<Box>(
                            valueListenable: categoryBox.listenable(),
                            builder: (context, box, _) {
                              if (box.isEmpty) {
                                return TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Categories()));
                                    },
                                    child: const Text('Create Category'));
                              }
                              return DropdownMenu<ExpenseCategory>(
                                initialSelection: categoryBox.getAt(0),
                                controller: _categoryController,
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        border: InputBorder.none),
                                dropdownMenuEntries: categoryBox.values
                                    .map<DropdownMenuEntry<ExpenseCategory>>(
                                        (dynamic cat) {
                                  ExpenseCategory category =
                                      cat as ExpenseCategory;
                                  return DropdownMenuEntry(
                                      value: category,
                                      label: category.name,
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStatePropertyAll(
                                                  category.color)));
                                }).toList(),
                              );
                            })),
                    ListTile(
                      title: const Text('Note'),
                      trailing: IntrinsicWidth(
                        child: TextField(
                          textAlign: TextAlign.end,
                          controller: _noteController,
                          decoration: const InputDecoration(
                              hintText: 'Note', border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
                
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: createExpense, child: const Text('Add Expense'))
            ],
          ),
        ));
  }
}
