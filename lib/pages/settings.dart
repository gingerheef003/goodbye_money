import 'package:flutter/material.dart';
import 'package:goodbye_money/pages/categories.dart';
import 'package:goodbye_money/types/widget.dart';

class Settings extends WidgetWithTitle {
  const Settings({super.key}) : super(title: "Settings");

  void handleEraseData() {
    print('Erase Data');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      // height: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: const Text('Categories'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Categories(),
                  )
                );
              },
            ),
            ListTile(
              title: const Text('Erase data', style: TextStyle(color: Colors.red),),
              onTap: () {
                showAlertDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}


showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: const Text("Are you sure?"),
    content: const Text("This action cannot be undone."),
    actions: [
      TextButton(onPressed: () {

        }, child: const Text("Cancel")
        ),
      TextButton(onPressed: () {

      }, child: const Text("Erase data", style: TextStyle(color: Colors.red),))
    ],
  );

  showDialog(context: context, builder: (BuildContext context) {
    return alert;
  });

}