import 'package:cripto_app/config/colors.dart';
import 'package:cripto_app/config/router/app_router.dart';
import 'package:cripto_app/login/presentation/cubit/login_cubit.dart';
import 'package:cripto_app/utils/responsive.dart';
import 'package:cripto_app/utils/strings.dart';
import 'package:cripto_app/widgets/button.dart';
import 'package:cripto_app/widgets/custom_textfield.dart';
import 'package:cripto_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginCubit loginCubit;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loginCubit = BlocProvider.of<LoginCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: Builder(
        builder: (context) => BlocBuilder<LoginCubit, LoginState>(builder: (_, state) {
          switch (state.runtimeType) {
            case LoginInitial:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    /*GestureDetector(
                      onTap: () {
                        loginCubit.loginWitchGoogle(() {
                          appRouter.replaceNamed('/base-nav-bar');
                        });
                      },
                      child: SocialButton(
                        tittle: initGoogle,
                        customWidth: 90.w,
                        color: ColorsApp.white,
                        textColor: ColorsApp.primaryColor,
                        image: Images.logoGoogle,
                        imageColor: ColorsApp.primaryColor,
                        borderColor: ColorsApp.primaryColor,
                      ),
                    ),
                    SizedBox(height: 4.h),*/
                    Padding(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              initEmail,
                              style: TextStyle(
                                color: ColorsApp.grey,
                                fontFamily: 'GilroyMedium',
                                fontSize: 18,
                              ),
                            ),
                          ),
                          CustomTextField(
                            '',
                            emailController,
                            keyTextField: const Key('email_field'),
                          ),
                          SizedBox(height: 2.h),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              password,
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
                            keyTextField: const Key('password_field'),
                          ),
                          SizedBox(height: 2.h),
                          state.errorMessage != ''
                              ? Text(
                                  state.errorMessage!,
                                  style: const TextStyle(
                                    color: ColorsApp.error,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontFamily: 'GilroyMedium',
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: () {
                        loginCubit.loginWitchCredentials(() {
                          appRouter.replaceNamed('/base-view');
                        }, emailController!.text, passwordController!.text);
                      },
                      child: CustomButton.button(
                        initSession,
                        90.w,
                        Colors.transparent,
                        ColorsApp.primaryColor,
                        ColorsApp.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          notHaveAccountQuestion,
                          style: TextStyle(
                            color: ColorsApp.black,
                            fontSize: 14,
                            fontFamily: 'GilroyMedium',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            appRouter.pushNamed('/register-view');
                          },
                          child: const Text(
                            register,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorsApp.primaryColor,
                              fontSize: 14,
                              fontFamily: 'GilroyBold',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            case LoginLoading:
              return const Loading();
            default:
              return const SizedBox();
          }
        }),
      ),
    );
  }
}
