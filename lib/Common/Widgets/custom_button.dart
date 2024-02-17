import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  final Color? color;
  const CustomButton({
    super.key,
    required this.text,
    required this.onpressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: color ?? GlobalVariables.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color == null ? GlobalVariables.backgroundColor : Colors.black,
        ),
      ),
    );
  }
}
