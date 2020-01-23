import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'expense.dart';

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
            padding: const EdgeInsets.only(top: 10, right: 10),
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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 18),
            ),
          ),
          title: Text(expense.title),
          subtitle: Text(DateFormat.yMd().format(expense.time)),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Are you sure?"),
                        content: Text(
                            "Are you sure you want to delete this expense?"),
                        actions: <Widget>[
                          RaisedButton(
                            child: Text("Yes"),
                            onPressed: () {
                              Provider.of<Expenses>(context, listen: false)
                                  .deleteExpense(expense.id);
                              Navigator.of(context).pop();
                            },
                          ),
                          RaisedButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ));
            },
            color: Colors.red,
            iconSize: 30,
          ),
        ),
      ),
    );
  }
}
