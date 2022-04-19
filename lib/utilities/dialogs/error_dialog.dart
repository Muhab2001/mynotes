import 'package:flutter/cupertino.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog<void>(
      context: context,
      title: "An Error Occured",
      content: text,
      optionsBuilder: () => {"OK": null});
}