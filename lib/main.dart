import 'package:flutter/material.dart';

import 'expense.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expenses",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [
    Expense("Laptop", 2000, DateTime.now()),
    Expense("Laptop", 2000, DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses Overview"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ExpenseItem(expenses[index]),
        itemCount: expenses.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        elevation: 15,
      ),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  ExpenseItem(this.expense);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "\$ ${expense.amount.toString()}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(expense.title),
          subtitle: Text(expense.time.toIso8601String()),
        ),
      ),
    );
  }
}
