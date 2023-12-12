import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.buttonText,
    required this.buttonIcon,
    this.buttonValue,
    this.height = 60,
    this.width = 160,
    required this.onPressed,
  }) : super(key: key);

  final String buttonText;
  final IconData buttonIcon;
  final String? buttonValue;
  final void Function() onPressed;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
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
                    size: 25,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    buttonValue!,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            if (buttonValue == null)
              Icon(
                buttonIcon,
                size: 30,
              ),
            Text(
              buttonText,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
