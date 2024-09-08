import 'package:flutter/material.dart';
void showSnackBar(BuildContext context, String message, bool isSuccess) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
