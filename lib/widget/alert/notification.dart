import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

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
