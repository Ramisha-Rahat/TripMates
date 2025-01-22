import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressedAction;

  const SquareButton({
    super.key,
    required this.buttonText,
    required this.onPressedAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 70),
      child: ElevatedButton(
        onPressed: onPressedAction, // Invoke the callback here
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText, // Use the passed buttonText
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
