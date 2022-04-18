/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: transactions.dart
  Description: This is the transaction model that we use to structure specific information about a transaction.
               It has the same structure that is implented in the firebase database. Each transaction travel card in a 
               users account will hold the follwing:
               - ID
               - Amount charged on day of transaction
               - Date of transaction
               - Name of Operator on day of transaction 
               - Route name/number on day of transaction
               - Logo of the operator
*/

class Transactions {
  Transactions({
    required this.operatorLogo,
  });

  String? transactionID;
  double? amount;
  late DateTime date;
  String? transportOperator;
  late String route;
  late String operatorLogo;

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'date': date,
        'operator': transportOperator,
        'route': route,
      };
  Transactions.fromSnapshot(snapshot)
      : transactionID = snapshot.id,
        amount = snapshot.data()['amount'].toDouble(),
        date = snapshot.data()['date'].toDate(),
        transportOperator = snapshot.data()['operator'],
        operatorLogo = (snapshot.data()['operator'] == "Dublin Bus")
            ? 'assets/dublinBusLogo.png'
            : (snapshot.data()['operator'] == "Go Ahead")
                ? 'assets/goAheadLogo.png'
                : (snapshot.data()['operator'] == "Iarnrod Eireann")
                    ? 'assets/iarnrodEireannLogo.png'
                    : (snapshot.data()['operator'] == "Luas")
                        ? 'assets/luasLogo.png'
                        : "",
        route = snapshot.data()['route'];
}
