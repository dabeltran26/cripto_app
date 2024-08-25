import 'package:cripto_app/config/colors.dart';
import 'package:cripto_app/profile/presentation/cubit/profile_cubit.dart';
import 'package:cripto_app/profile/presentation/widget/update_password_form.dart';
import 'package:cripto_app/resources/models/user_model.dart';
import 'package:cripto_app/utils/responsive.dart';
import 'package:cripto_app/widgets/button.dart';
import 'package:cripto_app/widgets/custom_textfield.dart';
import 'package:cripto_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileCubit profileCubit;
  final formKey = GlobalKey<FormState>();
  bool isEditable = false;
  late TextEditingController birthdayController;
  late TextEditingController nameController;
  late int age;
  late DateTime? birthday;

  @override
  void initState() {
    profileCubit = BlocProvider.of<ProfileCubit>(context);
    profileCubit.getUser();
    birthdayController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(profileCubit.user.birthday));
    nameController = TextEditingController(text: profileCubit.user.name);
    age = profileCubit.user.age;
    birthday = profileCubit.user.birthday;
    super.initState();
  }

  @override
  void dispose() {
    birthdayController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: Builder(
        builder: (context) => BlocBuilder<ProfileCubit, ProfileState>(builder: (_, state) {
          switch (state.runtimeType) {
            case ProfileSuccess:
              return SafeArea(
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Perfil',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'GilroyBold',
                                  color: ColorsApp.black,
                                  fontSize: 30),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEditable = !isEditable;
                                });
                              },
                              child: Text(
                                isEditable ? 'Cancelar' : 'Editar',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'GilroyBold',
                                    color: ColorsApp.black,
                                    fontSize: 16),
                              ),
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
                            }, enabled: isEditable),
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
                                onTap: () => selectBirthday(context),
                                enabled: isEditable),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      GestureDetector(
                        onTap: () {
                          showUpdatePasswordBottomSheet(context);
                        },
                        child: CustomButton.button(
                          'Actualizar contraseña',
                          90.w,
                          Colors.transparent,
                          ColorsApp.primaryColor,
                          ColorsApp.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      GestureDetector(
                        onTap: () {
                          if (isEditable) {
                            submitForm();
                          }
                        },
                        child: CustomButton.button(
                          'Actualizar informacion',
                          90.w,
                          Colors.transparent,
                          isEditable ? ColorsApp.primaryColor : ColorsApp.grey,
                          ColorsApp.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            case ProfileLoading:
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
        birthdayController.text = DateFormat('yyyy-MM-dd').format(picked);
        birthday = picked;
        age = DateTime.now().year - picked.year;
      });
    }
  }

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      if (age != 0 && age >= 18) {
        var user = UserModel(
            email: profileCubit.user.email,
            name: nameController.text,
            birthday: birthday!,
            age: age,
            uid: profileCubit.user.uid);
        profileCubit.updateUser(user, () {});
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

  void showUpdatePasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: UpdatePasswordForm(
            profileCubit: profileCubit,
          ),
        );
      },
    );
  }
}
