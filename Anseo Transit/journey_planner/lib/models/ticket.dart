/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: ticket.dart
  Description: This is the ticket model that we use to structure specific information about the ticket.It has the 
               same structure that is implented in the firebase database. Each ticket in a users account will
               hold the follwing:
               - ID
               - Activation Status
               - Amount Charged
               - Date of Transaction
               - Name of Operator on day of transaction 
               - Price of ticket
               - Route name/number on day of transaction
               - Transaction ID
               - Ticket Type
*/

class Ticket {
  Ticket();

  String? ticketID;
  bool? activated;
  double? amount;
  DateTime? date;
  String? transportOperator;
  double? price;
  String? route;
  String? transactionID;
  String? type;

  Map<String, dynamic> toJson() => {
        'ticket_id': ticketID,
        'activated': activated,
        'amount': amount,
        'date': date,
        'operator': transportOperator,
        'price': price,
        'route': route,
        'transaction_id': transactionID,
        'type': type,
      };

  Ticket.fromSnapshot(snapshot)
      : ticketID = snapshot.id,
        activated = snapshot.data()['activated'],
        amount = snapshot.data()['amount'].toDouble(),
        date = snapshot.data()['date'].toDate(),
        transportOperator = snapshot.data()['operator'],
        price = snapshot.data()['price'].toDouble(),
        route = snapshot.data()['route'],
        transactionID = snapshot.data()['transaction_id'],
        type = snapshot.data()['type'];
}
