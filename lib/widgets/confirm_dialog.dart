import 'package:flutter/material.dart';

Future<bool> confirmDialog({
  required final context,
  required String warningText,
  required String actionButtonText,
}) async {
  bool? val = await showDialog<bool>(
    barrierColor: Colors.black.withOpacity(0.8),
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Icon(
        Icons.warning_rounded,
        size: 75,
      ),
      content: SingleChildScrollView(
        child: Text(
          warningText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: <Widget>[
        SizedBox(
          width: 100,
          height: 50,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 100,
          height: 50,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
            ),
            child: Text(
              actionButtonText,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  return val ?? false;
}
