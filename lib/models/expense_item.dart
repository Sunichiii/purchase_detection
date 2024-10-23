class ExpenseItem{
  final String name;
  final String amount;
  final DateTime dateTime;
  final String cardUsed;

  ExpenseItem({
    required this.dateTime,
    required this.amount,
    required this.name,
    required this.cardUsed,
  });
}