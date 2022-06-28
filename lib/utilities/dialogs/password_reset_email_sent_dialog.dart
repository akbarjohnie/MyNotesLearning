import 'package:flutter/material.dart';
import 'package:mynotesapp/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password reset',
    content: 'We have now sent you a password reset link',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
