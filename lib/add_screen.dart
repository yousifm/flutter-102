import 'package:flutter/material.dart';
import 'package:flutter_102/expense.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  static const routeName = "/add-note";

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  var pickedDate = DateTime.now();

  final titleController = TextEditingController();

  final amountController = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', leftSymbol: '\$ ');

  @override
  Widget build(BuildContext context) {
    final e = Provider.of<Expenses>(context);
    final expenses = e.expenses;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "Expense Name"),
              controller: titleController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: amountController,
            ),
            Container(
              width: 100,
              child: OutlineButton(
                child: Text(
                  "${pickedDate.year}/${pickedDate.month}/${pickedDate.day}",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                onPressed: () => showDatePicker(
                        context: context,
                        firstDate: DateTime.now().subtract(Duration(days: 30)),
                        lastDate: DateTime.now().add(Duration(days: 30)),
                        initialDate: pickedDate)
                    .then((val) {
                  setState(() {
                    pickedDate = val;
                  });
                }),
              ),
            ),
            Container(
              width: 100,
              child: RaisedButton(
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  e.addExpense(titleController.text,
                      amountController.numberValue, pickedDate);

                  titleController.clear();
                  amountController.clear();
                  pickedDate = DateTime.now();
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
