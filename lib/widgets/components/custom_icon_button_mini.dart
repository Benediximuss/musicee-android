import 'package:flutter/material.dart';
import 'package:musicee_app/utils/color_manager.dart';

class CustomIconButtonMini extends StatelessWidget {
  const CustomIconButtonMini({
    Key? key,
    required this.buttonText,
    required this.buttonIcon,
    required this.onPressed,
    this.height = 30,
    this.width = 100,
    this.borderWidth = 2,
    this.borderRadius = 10,
    this.fontSize = 18,
    this.iconSize = 18,
  }) : super(key: key);

  final String buttonText;
  final IconData buttonIcon;
  final void Function() onPressed;
  final double height;
  final double width;
  final double borderWidth;
  final double borderRadius;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
            width: borderWidth,
            color: ColorManager.colorPrimary,
          ),
        ),
        child: SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.colorPrimary),
              ),
              const SizedBox(width: 5),
              Icon(
                buttonIcon,
                size: iconSize,
                color: ColorManager.colorPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
