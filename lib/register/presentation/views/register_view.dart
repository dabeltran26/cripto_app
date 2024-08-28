import 'package:cripto_app/config/colors.dart';
import 'package:cripto_app/config/router/app_router.dart';
import 'package:cripto_app/register/presentation/cubit/register_cubit.dart';
import 'package:cripto_app/utils/responsive.dart';
import 'package:cripto_app/widgets/button.dart';
import 'package:cripto_app/widgets/custom_textfield.dart';
import 'package:cripto_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late RegisterCubit registerCubit;
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? birthdayController;
  DateTime? birthday;
  late int age;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    birthdayController = TextEditingController();
    age = 0;
    registerCubit = BlocProvider.of<RegisterCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: Builder(
        builder: (context) => BlocBuilder<RegisterCubit, RegisterState>(builder: (_, state) {
          switch (state.runtimeType) {
            case RegisterInitial:
              return SafeArea(
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                appRouter.pop();
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: ColorsApp.primaryColor,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Crear cuenta',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'GilroyBold',
                                  color: ColorsApp.black,
                                  fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nombre',
                                style: TextStyle(
                                  color: ColorsApp.grey,
                                  fontFamily: 'GilroyMedium',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            CustomTextField('', nameController, validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo es obligatorio';
                              }
                              return null;
                            }),
                            SizedBox(height: 1.h),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Correo electronico',
                                style: TextStyle(
                                  color: ColorsApp.grey,
                                  fontFamily: 'GilroyMedium',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            CustomTextField('', emailController, validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo es obligatorio';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Ingresa un email válido';
                              }
                              return null;
                            }),
                            SizedBox(height: 1.h),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Contraseña',
                                style: TextStyle(
                                  color: ColorsApp.grey,
                                  fontFamily: 'GilroyMedium',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            CustomTextField(
                              '',
                              passwordController,
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                                if (value.length < 6) {
                                  return 'La contraseña debe tener al menos 6 caracteres';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 1.h),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Fecha de Nacimiento',
                                style: TextStyle(
                                  color: ColorsApp.grey,
                                  fontFamily: 'GilroyMedium',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            CustomTextField('', birthdayController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Este campo es obligatorio';
                                  }
                                  return null;
                                },
                                onTap: () => selectBirthday(context)),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            Checkbox(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              activeColor: ColorsApp.primaryColor,
                              side: const BorderSide(
                                color: ColorsApp.primaryColor,
                              ),
                              value: isChecked,
                              splashRadius: 1,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Al iniciar sesión aceptas los ',
                                      style:
                                          TextStyle(color: ColorsApp.black, fontSize: 15, fontFamily: 'GilroyMedium'),
                                    ),
                                    TextSpan(
                                      text: 'Términos & condiciones y',
                                      style: TextStyle(
                                          color: ColorsApp.primaryColor,
                                          fontSize: 15,
                                          fontFamily: 'GilroyMedium',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: 'Nuestra política de privacidad.',
                                      style: TextStyle(
                                          color: ColorsApp.primaryColor,
                                          fontSize: 15,
                                          fontFamily: 'GilroyMedium',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      GestureDetector(
                        onTap: () {
                          isChecked ? submitForm() : null;
                        },
                        child: CustomButton.button(
                          'Crear cuenta',
                          90.w,
                          Colors.transparent,
                          isChecked ? ColorsApp.primaryColor : ColorsApp.black60,
                          ColorsApp.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Ya tengo una cuenta ',
                            style: TextStyle(
                              color: ColorsApp.black,
                              fontSize: 14,
                              fontFamily: 'GilroyMedium',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              appRouter.pop();
                            },
                            child: const Text(
                              'Iniciar sesión',
                              style: TextStyle(
                                color: ColorsApp.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'GilroyBold',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            case RegisterLoading:
              return const Loading();
            default:
              return const SizedBox();
          }
        }),
      ),
    );
  }

  Future<void> selectBirthday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthdayController!.text = DateFormat('yyyy-MM-dd').format(picked);
        birthday = picked;
        age = DateTime.now().year - picked.year;
      });
    }
  }

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      if (age != 0 && age >= 18) {
        registerCubit.registerWitchCredentials(() {
          appRouter.replaceNamed('/base-view');
        }, emailController!.text, passwordController!.text, nameController!.text, age, birthday!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Debes ser mayor de 18 años'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
