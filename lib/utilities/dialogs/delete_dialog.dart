import 'package:flutter/cupertino.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Delete",
    content: "Are you sure you want to Delete this item?",
    optionsBuilder: () => {
      "Cancel": false,
      "Yes": true,
    },
    // because android can dismiss using the back button
  ).then((value) => value ?? false);
}
