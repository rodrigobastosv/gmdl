import 'package:flutter/material.dart';

import 'package:flash/flash.dart';

void showErrorNotification(BuildContext context, String errorMessage) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 2),
    builder: (context, controller) {
      return Flash.bar(
        controller: controller,
        backgroundGradient: const LinearGradient(
          colors: [
            Colors.red,
            Colors.redAccent,
            Colors.red,
          ],
        ),
        position: FlashPosition.top,
        enableDrag: true,
        horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
        margin: const EdgeInsets.all(8),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.slowMiddle,
        child: FlashBar(
          message: Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          icon: const Icon(
            Icons.info,
            color: Colors.white,
          ),
          shouldIconPulse: false,
        ),
      );
    },
  );
}

void showSuccessNotification(BuildContext context, String successMessage) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 2),
    builder: (context, controller) {
      return Flash.bar(
        controller: controller,
        backgroundGradient: const LinearGradient(
          colors: [
            Colors.green,
            Colors.greenAccent,
            Colors.green,
          ],
        ),
        position: FlashPosition.top,
        enableDrag: true,
        horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
        margin: const EdgeInsets.all(8),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.slowMiddle,
        child: FlashBar(
          message: Text(
            successMessage,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          icon: const Icon(
            Icons.info,
            color: Colors.white,
          ),
          shouldIconPulse: false,
        ),
      );
    },
  );
}
