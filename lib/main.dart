import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'expense.dart';

//Tells flutter to run an instance of MyApp once the program starts
main() => runApp(MyApp());

//StatelessWidget means this widget doesn't need to redraw when data changes
class MyApp extends StatelessWidget {
  //Each widget has a build function that returns what flutter needs to draw
  //Flutter provides a BuildContext with carries data about the widget tree
  @override
  Widget build(BuildContext context) {
    /* We are returning a MaterialApp which is the flutter widget to initialize
     * an android app. If we were to create an ios app we would import
     * cupertino.dart from flutter and use the CupertinoApp widget
     */
    return MaterialApp(
      title: "Expenses", //Name of the app
      home: HomeScreen(), //The screen to show on app start
    );
  }
}

/* A stateful widget is usually divided into two parts one that inherits from
 * the StatefulWidget class and one that inherits from the State class
 * The Widget part handles passing down of arguments while the State
 * handles drawing and redrawing of the widget
 */
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  //createState is used to tell Flutter the state class associated with this
  //stateful widget

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//This is the State class and it defines what it's widget is by using the
//angled brackets notation State<widgetname>

class _HomeScreenState extends State<HomeScreen> {
  //Sample expenses list for testing
  List<Expense> expenses = [
    Expense("Laptop", 2000, DateTime.now()),
    Expense("Laptop", 2000, DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
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
      body: ListView.builder(
        itemBuilder: (context, index) => ExpenseItem(expenses[index]),
        itemCount: expenses.length,
      ),

      /* A floatingActionButton is an android specific widget that shows a
       * floating button at the bottom of the screen. This one is another
       * example of a button that is emphasized and easily accessible by
       * the user
       */
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        elevation: 15,
      ),
    );
  }
}

//Custom widget we created to handle displaying expense data
class ExpenseItem extends StatelessWidget {
  final Expense expense;

  ExpenseItem(this.expense);

  @override
  Widget build(BuildContext context) {
    //The Padding widget adds some space around its child widget
    return Padding(
      /* The EdgeInsets class defines directional area. usually passed to when
       * padding or margin are needed.
       * In this case we want all sides to have the same amount of space around
       * so we use the EdgeInsets.all constructor
       */
      padding: const EdgeInsets.all(10),
      //The Card class creates a floating Card containing the widgets you pass
      //to it
      child: Card(
        //Elevation handles how much shadow is shown under the card
        elevation: 5,

        /* A ListTile is a Flutter widget that is designed to be shown in a list
         * its most important parameters are: 
         * leading: what is shown at the beginning of the tile
         * title and subtitle: to be shown in the middle of the tile
         * trailing: to be shown at the end of the tile
         */
        child: ListTile(
          leading: Padding(
            /* We only need padding on top, so we use the EdgeInsets.only
             * constructor and pass the amount of padding the top side needs.
             */
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              /* The $ character is a special string character in flutter and it
               * indicates that we need to use a variable from the code in the
               * string. The first $ is 'escaped' by adding a \ character
               * before it to tell flutter we want to display a $ character
               * and not use its special functionality
              */
              "\$ ${expense.amount.toString()}",
              /* The style parameter accepts a TextStyle instance that defines
               * how the text is to be shown and styled. It can contain colors,
               * fonts, fontsize, weight and so on.
               */

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
