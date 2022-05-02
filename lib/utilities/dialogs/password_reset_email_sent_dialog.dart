import 'package:flutter/cupertino.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Password Reset",
    content:
        "We have now sent you a password reset link, Please check your emal for more informtion",
    optionsBuilder: () => {"OK": null},
  );
}
