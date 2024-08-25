import 'package:cripto_app/config/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool? isPassword;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final Color? borderColor;
  final Function? onChange;
  final bool? enabled;

  const CustomTextField(this.hintText, this.controller,
      {super.key,
      this.isPassword = false,
      this.validator,
      this.onTap,
      this.borderColor = ColorsApp.grey,
      this.onChange,
      this.enabled = true});

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
          onChanged: (String value) {
            if (widget.onChange != null) {
              widget.onChange!(value);
            }
          },
          enabled: widget.enabled,
          cursorColor: ColorsApp.primaryColor,
          onTap: widget.onTap,
          controller: widget.controller,
          style: const TextStyle(color: ColorsApp.black),
          obscureText: obscureText,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsApp.primaryColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor!,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.only(left: 10),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: ColorsApp.grey,
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
