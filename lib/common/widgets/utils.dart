// import 'dart:io';
import 'package:flutter/material.dart';

void showSnackBars(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
