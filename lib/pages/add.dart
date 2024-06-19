import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodbye_money/models/boxes.dart';
import 'package:goodbye_money/models/category.dart';
import 'package:goodbye_money/types/widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
                      trailing: SizedBox(
                        width: 60,
                        child: TextField(
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          controller: _amountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            hintText: 'Amount',
                            // border: InputBorder.none
                          ),
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
                      title: const Text('Note'),
                      trailing: SizedBox(
                        width: 60,
                        child: TextField(
                          textAlign: TextAlign.end,
                          controller: _noteController,
                          decoration: const InputDecoration(
                            hintText: 'Note',
                            // border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                        title: const Text('Category'),
                        trailing: DropdownMenu<ExpenseCategory>(
                          initialSelection: boxCategory.getAt(0),
                          controller: _categoryController,
                          inputDecorationTheme: const InputDecorationTheme(
                              border: InputBorder.none),
                          dropdownMenuEntries: boxCategory.values
                              .map<DropdownMenuEntry<ExpenseCategory>>(
                                  (dynamic cat) {
                            ExpenseCategory category = cat as ExpenseCategory;
                            return DropdownMenuEntry(
                              value: category,
                              label: category.name,
                            );
                          }).toList(),
                        )),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("Amount"),
                    //     const Spacer(),
                    //     Flexible(
                    //       child: TextField(
                    //         textAlign: TextAlign.end,
                    //         keyboardType: TextInputType.number,
                    //         controller: _amountController,
                    //         inputFormatters: [
                    //           FilteringTextInputFormatter.digitsOnly,
                    //         ],
                    //         decoration: const InputDecoration(
                    //           hintText: 'Amount',
                    //           // border: InputBorder.none
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("Date"),
                    //     TextButton(
                    //         onPressed: () => selectDate(context),
                    //         child: Text(
                    //             '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'))
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("Note"),
                    //     const Spacer(),
                    //     Flexible(
                    //       // width: 100,
                    //       child: TextField(
                    //         textAlign: TextAlign.end,
                    //         controller: _noteController,
                    //         decoration: const InputDecoration(
                    //           hintText: 'Note',
                    //           // border: InputBorder.none
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("Category"),
                    //     DropdownMenu<ExpenseCategory>(
                    //       initialSelection: boxCategory.getAt(0),
                    //       controller: _categoryController,
                    //       inputDecorationTheme: const InputDecorationTheme(
                    //           border: InputBorder.none),
                    //       dropdownMenuEntries: boxCategory.values
                    //           .map<DropdownMenuEntry<ExpenseCategory>>(
                    //               (dynamic cat) {
                    //         ExpenseCategory category = cat as ExpenseCategory;
                    //         return DropdownMenuEntry(
                    //           value: category,
                    //           label: category.name,
                    //         );
                    //       }).toList(),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
