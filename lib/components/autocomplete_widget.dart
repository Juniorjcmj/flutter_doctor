// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AutocompleteWidget<T extends Object> extends StatelessWidget {
  final List<T> options;
  final String Function(T option) displayStringForOption;
  final Widget Function(T option) buildListTile;
  final T? Function(T option) onSelected;
  InputDecoration inputDecoration;

  AutocompleteWidget({
    super.key, 
    required this.options,
    required this.displayStringForOption,
    required this.buildListTile,
    required this.onSelected,
    this.inputDecoration = const InputDecoration(labelText: "Buscar")
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return options.where((T option) {
          final optionText = displayStringForOption(option).toLowerCase();
          final queryText = textEditingValue.text.toLowerCase();
          return optionText.contains(queryText);
        }).toList();
      },
      displayStringForOption: (T option) => displayStringForOption(option),
      onSelected: (T option) => onSelected(option),
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: inputDecoration,
          
          onSubmitted: (String value) {
            onFieldSubmitted();
          },
        
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: buildListTile(option),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

