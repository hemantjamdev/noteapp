import 'package:flutter/material.dart';
import 'package:noteapp/constant/strings.dart';

Future<bool> confirmationDialog(
    {required BuildContext context, required String message}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(message, textAlign: TextAlign.center),
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(Strings.yes)),
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(Strings.no))
        ],
      );
    },
  );
}
