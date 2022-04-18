import 'package:flutter/material.dart';

//  strings are titles, and Ts are output values
typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>(
    {required BuildContext context,
    required String title,
    required String content,
    required DialogOptionBuilder optionsBuilder}) {
  final options = optionsBuilder();
  return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          // requires a list of widgets (buttons in this case)
          actions: options.keys.map((optionTitle) {
            final value = options[optionTitle];
            return TextButton(
                onPressed: () {
                  if (value != null) {
                    Navigator.of(context).pop(value);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(optionTitle));
          }).toList(),
        );
      });
}
