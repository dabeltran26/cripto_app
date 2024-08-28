import 'package:cripto_app/config/colors.dart';
import 'package:cripto_app/profile/presentation/cubit/profile_cubit.dart';
import 'package:cripto_app/utils/responsive.dart';
import 'package:cripto_app/widgets/button.dart';
import 'package:cripto_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class UpdatePasswordForm extends StatefulWidget {
  final ProfileCubit profileCubit;

  const UpdatePasswordForm({super.key, required this.profileCubit});

  @override
  State<UpdatePasswordForm> createState() => _UpdatePasswordFormState();
}

class _UpdatePasswordFormState extends State<UpdatePasswordForm> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 4.h),
            CustomTextField(
              'Contraseña nueva',
              passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es obligatorio';
                }
                return null;
              },
            ),
            SizedBox(height: 1.h),
            CustomTextField(
              'Confirma la contraseña',
              confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Debes confirmar la contraseña';
                }
                if (value != passwordController.text) {
                  return 'No coincide la contraseña';
                }
                return null;
              },
            ),
            SizedBox(height: 2.h),
            GestureDetector(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  widget.profileCubit.updatePassword(passwordController.text, () {});
                  Navigator.pop(context);
                }
              },
              child: CustomButton.button(
                'Actualizar contraseña',
                90.w,
                Colors.transparent,
                ColorsApp.primaryColor,
                ColorsApp.white,
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}
