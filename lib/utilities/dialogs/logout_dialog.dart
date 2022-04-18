import 'package:flutter/cupertino.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Log out",
    content: "Are you sure you want to log out?",
    optionsBuilder: () => {
      "Cancel": false,
      "Log out": true,
    },
    // because android can dismiss using the back button
  ).then((value) => value ?? false);
}
