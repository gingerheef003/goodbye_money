import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:goodbye_money/models/boxes.dart';
import 'package:goodbye_money/models/category.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Color pickerColor;
  late Color currentColor;

  // List<Category> categories = [
  //   Category(name: 'hello', colorValue: Colors.red),
  //   Category(name: 'hello', colorValue: Colors.blue),
  // ];

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    pickerColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    currentColor = pickerColor;
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void createCategory() {
    print(categoryBox.values.map((e) => e.name));
    print(categoryBox.values.map((e) => e.visible));
    if (_controller.text.isNotEmpty) {
      ExpenseCategory newCategory = ExpenseCategory(
          name: _controller.text, colorValue: currentColor.value);
      setState(() {
        categoryBox.put(newCategory.name, newCategory);
        currentColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
        pickerColor = currentColor;
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Categories"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ValueListenableBuilder<Box>(
                    valueListenable: categoryBox.listenable(),
                    builder: (context, box, _) {
                      var filteredBox = box.values.where((e) => e.visible).toList();
                      if (filteredBox.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 64),
                          child: Center(
                            child: Text("It's so lonely here..."),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredBox.length,
                        itemBuilder: (context, index) {
                          ExpenseCategory category = filteredBox[index];
                          if(category.visible) {
                            return ListTile(
                              title: Text('  ${category.name}\u00A0\u00A0',
                                  style: TextStyle(
                                    color: category.color,
                                    backgroundColor: category.color.withOpacity(0.3),
                                  )),
                              // leading: Container(
                              //   width: 18,
                              //   height: 18,
                              //   decoration: BoxDecoration(
                              //       color: category.color,
                              //       shape: BoxShape.circle),
                              // ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.black87,
                                          title: Text.rich(TextSpan(children: [
                                            const TextSpan(
                                                text: 'Delete Category  '),
                                            TextSpan(
                                                text: ' ${category.name}\u00A0',
                                                style: TextStyle(
                                                  color: category.color,
                                                  backgroundColor: category.color
                                                      .withOpacity(0.3),
                                                ))
                                          ])),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Cancel')),
                                            ElevatedButton(
                                                onPressed: () {
                                                  category.visible = false;
                                                  category.save();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Delete',
                                                    style: TextStyle(
                                                        color: Colors.red)))
                                          ],
                                        );
                                      });
                                },
                              ),
                            );
                          }
                        },
                      );
                    })),
            const Spacer(),
            SafeArea(
              bottom: true,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.black87,
                                title: const Text("Pick a color"),
                                content: SingleChildScrollView(
                                  child: BlockPicker(
                                    pickerColor: pickerColor,
                                    onColorChanged: changeColor,
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          currentColor = pickerColor;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Got it"))
                                ],
                              );
                            });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        // padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: currentColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: TextField(
                      controller: _controller,
                      decoration:
                          const InputDecoration(
                            hintText: 'Category Name',
                            border: InputBorder.none
                          ),
                    )),
                    IconButton(
                        onPressed: createCategory,
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 24,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
