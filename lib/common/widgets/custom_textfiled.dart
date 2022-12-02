import 'package:flutter/material.dart';

class CustomTextFiled extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  const CustomTextFiled(
      {Key? key, required this.controller, required this.hintText})
      : super(key: key);

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter your ${widget.hintText}";
        }
        return null;
      },
    );
  }
}
