import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool? isLoading;
  const CustomButton({
    super.key,
    this.onTap,
    required this.text,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child:
              isLoading != null && !isLoading!
                  ? Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  : CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
