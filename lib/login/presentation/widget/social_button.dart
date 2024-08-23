import 'package:cripto_app/utils/responsive.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String? tittle;
  final double? customWidth;
  final Color? color;
  final Color? textColor;
  final String? image;
  final Color? imageColor;
  final Color? borderColor;

  const SocialButton(
      {super.key,
      this.tittle,
      this.customWidth,
      this.color,
      this.textColor,
      this.image,
      this.imageColor,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor!, width: 1.5),
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(22),
          ),
        ),
        height: 6.h,
        width: customWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(image!, height: 3.h, color: imageColor),
            Text(
              tittle!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
                fontSize: 18,
                fontFamily: 'GilroyBold',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
