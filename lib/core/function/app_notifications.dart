import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_colors.dart';

class AppNotifications {
  static showSuccess({
    required String message,
    Color color = Colors.green,
  }) {
    BotToast.showText(
      text: message,
      contentColor: color,
      onlyOne: true,
    );
  }

  static showError({
    required String message,
    Color color = Colors.red,
  }) {
    BotToast.showText(
      text: message,
      contentColor: color,
      onlyOne: true,
    );
  }

  static showMessage({
    required String message,
  }) {
    BotToast.showCustomText(
      toastBuilder: (context) => Container(
        padding: const EdgeInsets.all(10),
        color: AppColors.primary,
        child: Text(message),
      ),
      onlyOne: true,
    );
  }
}
