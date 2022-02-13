/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  File Description: THis is the transaction model - firebase

*/

class Transaction {
  Transaction({
    required this.transactionID,
    required this.amount,
    required this.date,
    required this.transportOperator,
    required this.route,
  });

  final String transactionID;
  final double amount;
  final DateTime date;
  final String transportOperator;
  final String route;
}
