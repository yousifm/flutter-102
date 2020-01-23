import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'expense_item.dart';
import 'add_screen.dart';
import 'expense.dart';

//Tells flutter to run an instance of MyApp once the program starts
main() =>
    runApp(ChangeNotifierProvider.value(value: Expenses(), child: MyApp()));

//StatelessWidget means this widget doesn't need to redraw when data changes

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* We are returning a MaterialApp which is the flutter widget to initialize
     * an android app. If we were to create an ios app we would import
     * cupertino.dart from flutter and use the CupertinoApp widget
     */
    return MaterialApp(
      title: "Expenses", //Name of the app
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (context) => HomeScreen(),
        AddNoteScreen.routeName: (context) => AddNoteScreen()
      },
    );
  }
}

/* A stateful widget is usually divided into two parts one that inherits from
 * the StatefulWidget class and one that inherits from the State class
 * The Widget part handles passing down of arguments while the State
 * handles drawing and redrawing of the widget
 */
class HomeScreen extends StatefulWidget {
  HomeScreen();

  //createState is used to tell Flutter the state class associated with this
  //stateful widget

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//This is the State class and it defines what it's widget is by using the
//angled brackets notation State<widgetname>

class _HomeScreenState extends State<HomeScreen> {
  //Sample expenses list for testing

  navigateToAddNote() {
    Navigator.of(context).pushNamed(AddNoteScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final e = Provider.of<Expenses>(context);

    //A Scaffold tells flutter that this widget takes up the entire area of
    //the screen
    return Scaffold(
      //The AppBar class handles drawing an android appbar at the top of the
      //screen
      appBar: AppBar(
        title: Text("Expenses Overview"),
        /* actions takes a list of widgets that are shown at the end of the
         * appbar, usually a list of buttons that you want to user to easily
         * have access to
         */
        actions: <Widget>[
          /* In this case we only have one button which is the button to add
           * an expense, it is an IconButton as it displays an icon instead
           * of text
           */
          IconButton(
            //We can use the Icon widget alongside one of the icons from
            //the Icons class that comes with Flutter to display an icon
            icon: Icon(Icons.add),
            //The Colors class also comes with Flutter and contains the
            //colors that are part of Google's material design
            color: Colors.white,
            //The onPressed parameter takes a function that is called when
            //the button is pressed
            onPressed: navigateToAddNote,
          )
        ],
      ),

      /* A ListView displays a list of items on screen, it can either be given
       * a list of widgets to display or a builder method that is passed a
       * function to render each element. providing a list of widgets means
       * building all widgets before the list is displayed adding some overhead
       * and storing widgets that aren't displayed to the user in memory,
       * while a builder method only builds the items that are displayed
       * onscreen which is more efficient
       */
      body: e.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) => ExpenseItem(e.expenses[index]),
              itemCount: e.expenses.length,
            ),

      /* A floatingActionButton is an android specific widget that shows a
       * floating button at the bottom of the screen. This one is another
       * example of a button that is emphasized and easily accessible by
       * the user
       */
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: navigateToAddNote,
        elevation: 15,
      ),
    );
  }
}
