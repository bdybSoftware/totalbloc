import 'package:flutter/foundation.dart';

//simple and silly print debug function to use debugPrint
// why?
// before productio release comment out the "debugPrint(message);" line to disable
// everywhere to terminate function without errors
// disabling shown below

void pd(String message) {
  if (kDebugMode) {
    debugPrint(message);
    // debugPrint(message); change above line to this to disable globally
  }
}
