/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: walkthrough_provider.dart
  Description: This file informs the provider assigned to 'walkthrough.dart' to update the current page that 
               the user is on and notify the listeners.
*/
import 'package:flutter/foundation.dart';

class WalkthroughProvider extends ChangeNotifier {
  int _currentPage = 0;

  /* 
    If the user moves on to a new page, that page number is updated to the current page 
    variable and all listeners are notified of the changes 
  */
  void onPageChange(int newPage) {
    _currentPage = newPage;
    notifyListeners();
  }

  int get currentPageValue => _currentPage;
}
