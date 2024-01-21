import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.buttonText,
    required this.buttonIcon,
    this.buttonValue,
    this.height = 60,
    this.width = 150,
    required this.onPressed,
    this.fontSize = 25,
    this.iconSize = 30,
    this.valueFontSize = 25,
    this.borderRadius = 10,
  }) : super(key: key);

  final String buttonText;
  final IconData buttonIcon;
  final String? buttonValue;
  final void Function() onPressed;
  final double height;
  final double width;
  final double fontSize;
  final double iconSize;
  final double valueFontSize;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: (buttonValue != null)
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.spaceEvenly,
          children: [
            if (buttonValue != null)
              Row(
                children: [
                  Icon(
                    buttonIcon,
                    size: iconSize,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    buttonValue!,
                    style: TextStyle(
                      fontSize: valueFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            if (buttonValue == null)
              Icon(
                buttonIcon,
                size: iconSize,
              ),
            Text(
              buttonText,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
