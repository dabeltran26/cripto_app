import 'package:cripto_app/config/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool? isPassword;

  const CustomTextField(this.hintText, this.controller, {super.key, this.isPassword = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword! ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: TextField(
        controller: widget.controller,
        style: const TextStyle(color: ColorsApp.black),
        obscureText: _obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: ColorsApp.black30,
            fontFamily: 'GilroyMedium',
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffE0E0E0),
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffE0E0E0),
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          suffixIcon: widget.isPassword!
              ? GestureDetector(
                  onTap: () {
                    _toggle();
                  },
                  child: _obscureText
                      ? const Icon(
                          Icons.remove_red_eye_rounded,
                          color: ColorsApp.grey,
                        )
                      : const Icon(
                          Icons.remove_red_eye_outlined,
                          color: ColorsApp.primaryColor,
                        ))
              : null,
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
