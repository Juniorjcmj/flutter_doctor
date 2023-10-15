import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/contaCorrente/model/conta_corrente.dart';
import 'package:flutter_doctor/shared/util/config.dart';

// ignore: must_be_immutable
class CumstomDropDownFieldForm extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> onChanged;
  final Widget prefixIcon;
  final String labelText;

  // ignore: use_key_in_widget_constructors
  CumstomDropDownFieldForm({
    required this.items,
    required this.onChanged,
    required this.prefixIcon,
    required this.labelText
  }) : selected= items.isNotEmpty ? items[0] : '';

   String selected;

  @override
  // ignore: library_private_types_in_public_api
  _CumstomDropDownFieldFormState createState() => _CumstomDropDownFieldFormState();
}

class _CumstomDropDownFieldFormState extends State<CumstomDropDownFieldForm> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(             
              value: widget.selected,             
              items: widget.items.map((e) {
                return DropdownMenuItem(
                  value:e,                  
                      child: Text(e,
                        style: const TextStyle(color: Config.secundColor),
                      ),
                                    
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  widget.selected = newValue!;
                  if (widget.onChanged != null) {
                    widget.onChanged(newValue!);
                  }
                });
              },
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: widget.labelText,
                  prefixIcon: widget.prefixIcon,
                 ),             
              
    );
  }
}
