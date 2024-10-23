import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final String cardUsed;

  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.cardUsed,
  });

  @override
  Widget build(BuildContext context) {
    // Convert hour to 12-hour format and determine AM/PM
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    String period = dateTime.hour >= 12 ? 'PM' : 'AM';

    // Handle edge case for midnight (12 AM)
    if (hour == 0) {
      hour = 12;
    }

    // Format for the time with 12-hour format and AM/PM
    String timeString = '$hour:${dateTime.minute.toString().padLeft(2, '0')} $period';

    return ListTile(
      title: Text(
        name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Font size for the expense name
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the start
        children: [
          Text(
            '${dateTime.day}/${dateTime.month}/${dateTime.year}', // Date in dd/mm/yyyy format
            style: const TextStyle(fontSize: 16), // Font size for the date
          ),
          Text(
            'Time: $timeString', // Time in 12-hour format with AM/PM
            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold), // Font size for the time
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the items vertically
        children: [
          Text(
            '\$$amount',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Font size for the amount
          ),
          Text(
            cardUsed,
            style: const TextStyle(fontSize: 16), // Font size for the card used
          ),
        ],
      ),
    );
  }
}
