import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';

void showErrorNotification(String errorMessage) {
  BotToast.showNotification(
    backgroundColor: const Color(0xFFB00020),
    title: (_) => Text(
      errorMessage,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}

void showSuccessNotification(String errorMessage) {
  BotToast.showNotification(
    backgroundColor: Colors.green,
    title: (_) => Text(
      errorMessage,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
