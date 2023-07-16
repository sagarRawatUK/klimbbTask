import 'package:flutter/material.dart';

class Utility {
  static double getTextSizeFormString(String size) {
    switch (size) {
      case "Small":
        return 14;
      case "Medium":
        return 16;
      case "Large":
        return 18;
      default:
        return 14;
    }
  }

  static String getTextSizeFormDouble(double size) {
    switch (size) {
      case 14:
        return "Small";
      case 16:
        return "Medium";
      case 18:
        return "Large";
      default:
        return "Small";
    }
  }

  static showDuplicateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Duplicate Record'),
          content: const Text(
              'These location coordinates are already associated with a profile.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
