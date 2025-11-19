import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message , color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1), backgroundColor: color,content: Center(child: Text(message))));
}