import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RowFormatters extends StatelessWidget {
  final String label;
  final TextInputFormatter formatter;
  final TextEditingController controller;
  final InputDecoration decoration;

  const RowFormatters(
      {super.key, required this.label, required this.formatter, required this.controller, required this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: decoration,
      textCapitalization: TextCapitalization.words,
      
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        formatter,
      ],
    );
  }
}