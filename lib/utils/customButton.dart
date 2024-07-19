import 'package:flutter/material.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:simple_animated_button/simple_animated_button.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  VoidCallback onPressed;
  CustomButton({super.key, required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedLayerButton(
      onClick: onPressed,
      buttonHeight: 50,
      buttonWidth: 100,
      animationDuration: const Duration(milliseconds: 100),
      animationCurve: Curves.ease,
      topDecoration: BoxDecoration(color: bgColor, border: Border.all()),
      topLayerChild: Text(
        btnText,
        style: TextStyle(color: secondaryColor1),
      ),
      baseDecoration: BoxDecoration(
        color: secondaryColor2,
        border: Border.all(),
      ),
    );
  }
}
