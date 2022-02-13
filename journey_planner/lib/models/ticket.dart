/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  File Description: THis is the ticket model - firebase

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
      : ticketID = snapshot.data()['ticket_id'],
        activated = snapshot.data()['activated'],
        amount = snapshot.data()['amount'],
        date = snapshot.data()['date'].toDate(),
        transportOperator = snapshot.data()['operator'],
        price = snapshot.data()['price'],
        route = snapshot.data()['route'],
        transactionID = snapshot.data()['transaction_id'],
        type = snapshot.data()['type'];
}
