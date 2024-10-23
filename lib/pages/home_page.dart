import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/expense_summary.dart';
import '../components/expense_tile.dart';
import '../data/expense_data.dart';
import '../models/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  final cardController = TextEditingController();

  // Method to show dialog and add new expense
  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Add a new expense", style: TextStyle(fontWeight: FontWeight.bold),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Expense name input
              TextField(
                controller: newExpenseNameController,
                decoration: InputDecoration(hintText: "Expense Name", hintStyle: TextStyle(color: Colors.grey[500])),
              ),
              // Expense amount input
              TextField(
                controller: newExpenseAmountController,
                decoration:
                InputDecoration(hintText: "Expense Amount",  hintStyle: TextStyle(color: Colors.grey[500])),
                keyboardType: TextInputType.number,
              ),
              // Card used input
              TextField(
                controller: cardController,
                decoration:  InputDecoration(hintText: "Card Used", hintStyle: TextStyle(color: Colors.grey[500])),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Save button
                MaterialButton(
                  onPressed: save,
                  child: const Text("Save",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ),
                // Cancel button
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ),
              ],
            )
          ],
        ));
  }

  // Method to save the expense
  void save() {
    ExpenseItem newExpense = ExpenseItem(
      dateTime: DateTime.now(),
      amount: newExpenseAmountController.text,
      name: newExpenseNameController.text,
      cardUsed: cardController.text,
    );

    // Add the new expense to the list
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    // Close the dialog
    Navigator.pop(context);
    clear();
  }

  // Method to cancel adding an expense
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // Method for clearing the text fields
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
    cardController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30,right: 10, left: 10),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white,),
        ),
        body: Consumer<ExpenseData>(
          builder: (context, value, child) {
            return ListView(
              children: [
                //weekly summary
                ExpenseSummary(startOfWeek: value.startOfWeekDate(),),
                const SizedBox(height: 50,),

                //expense List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenseList().length,
                  itemBuilder: (context, index) {
                    ExpenseItem expense = value.getAllExpenseList()[index];
                    return ExpenseTile(
                      name: expense.name,
                      amount: expense.amount,
                      dateTime: expense.dateTime,
                      cardUsed: expense.cardUsed,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
