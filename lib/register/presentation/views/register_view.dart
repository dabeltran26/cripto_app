import 'package:cripto_app/config/colors.dart';
import 'package:cripto_app/config/router/app_router.dart';
import 'package:cripto_app/register/presentation/cubit/register_cubit.dart';
import 'package:cripto_app/utils/responsive.dart';
import 'package:cripto_app/widgets/button.dart';
import 'package:cripto_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late RegisterCubit registerCubit;
  bool isChecked = false;
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
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
                    SizedBox(height: 6.h),
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
                          CustomTextField('', nameController),
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
                          CustomTextField('', emailController),
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
                          ),
                          SizedBox(height: 4.h),
                          Row(
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
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        isChecked
                            ? registerCubit.registerWitchCredentials(() {
                                //appRouter.pushNamed('/base-nav-bar');
                              }, emailController!.text, passwordController!.text, nameController!.text)
                            : null;
                      },
                      child: CustomButton.button(
                        'Crear cuenta',
                        90.w,
                        Colors.transparent,
                        isChecked ? ColorsApp.primaryColor : ColorsApp.black60,
                        ColorsApp.white,
                      ),
                    ),
                    SizedBox(height: 1.h),
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
              );
            case RegisterLoading:
              return Container();
            default:
              return const SizedBox();
          }
        }),
      ),
    );
  }
}
