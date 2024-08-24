import 'package:cripto_app/config/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool? isPassword;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;

  const CustomTextField(this.hintText, this.controller,
      {super.key, this.isPassword = false, this.validator, this.onTap});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText;

  @override
  void initState() {
    obscureText = widget.isPassword! ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: TextFormField(
          onTap: widget.onTap,
          controller: widget.controller,
          style: const TextStyle(color: ColorsApp.black),
          obscureText: obscureText,
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
                    child: obscureText
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
          validator: widget.validator),
    );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
