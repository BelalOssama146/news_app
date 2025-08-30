import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

/// Http Requests:
/// Request type ( get - post - delete - etc...)
/// Get Requests (BaseUrl + ApiName + "?" + arguments)  no Body
/// Post Requests (BaseUrl + ApiName + "?" + arguments(optional))
/// Args are mostly placed in post request body
/// Headers() ignore for now
/// -------------------------------
/// Response:
/// Body -> html || json(java script object notaion) {key(String) : dynamic} || xml
/// Headers
/// status code(int) 40x -> clients error|| 50x -> server error || 20x -> successful