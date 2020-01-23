import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class Expense {
  String id;
  String title;
  double amount;
  DateTime time;

  Expense(this.title, this.amount, this.time) {
    id = time.millisecondsSinceEpoch.toString();
  }
}

//Expense("Laptop", 2000, DateTime.now());

class Expenses with ChangeNotifier {
  List<Expense> _expenses = [];
  bool _loading = true;

  String table = "expense";
  String dbFile = "expensedb.db";

  Expenses() {
    getFromDatabase();
  }

  get expenses => _expenses;
  get loading => _loading;

  getFromDatabase() async {
    _loading = true;

    WidgetsFlutterBinding.ensureInitialized();

    final db = await openDatabase(dbFile,
        version: 1,
        onCreate: (db, version) => db.execute(
            "CREATE TABLE $table(id TEXT PRIMARY KEY, title TEXT, amount REAL, date NUMBER)"));

    final val = await db.query(table);

    for (var item in val) {
      final e = Expense(item['title'], item['amount'],
          DateTime.fromMillisecondsSinceEpoch(item['date']));
      _expenses.add(e);
    }
    _loading = false;

    notifyListeners();
  }

  addExpense(String title, double amount, DateTime time) async {
    final e = Expense(title, amount, time);
    expenses.add(e);

    notifyListeners();

    final db = await openDatabase(dbFile);
    db.execute(
        "INSERT INTO $table(id, title, amount, date) VALUES(\"${e.id}\", \"${e.title}\", ${e.amount}, ${e.time.millisecondsSinceEpoch})");
  }

  deleteExpense(String id) async {
    //Expense e = _expenses.firstWhere((val) => val.id == id);
    //_expenses.remove(e);

    _expenses.removeWhere((val) => val.id == id);

    final db = await openDatabase(dbFile);
    db.execute("DELETE FROM $table WHERE id=$id");
    notifyListeners();
  }
}
