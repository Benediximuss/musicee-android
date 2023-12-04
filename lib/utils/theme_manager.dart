import 'package:flutter/material.dart';
import 'package:musicee_app/utils/color_manager.dart';

final class ThemeManager {
  static OutlineInputBorder buildFormOutline(TextEditingController controller) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: controller.text.isEmpty
            ? Colors.red
            : ColorManager.swatchPrimary.shade700,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
