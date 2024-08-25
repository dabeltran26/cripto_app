import 'package:cripto_app/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomButton {
  static Widget button(text, w, borderColor, backgroundColor, textColor) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1.5),
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        height: 6.h,
        width: w,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 20, fontFamily: 'GilroyBold'),
          ),
        ),
      ),
    );
  }
}
