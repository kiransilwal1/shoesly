import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  print(content);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
}
