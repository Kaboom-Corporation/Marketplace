import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/consts.dart';
import 'package:marketplace/pages/purchaser/register/register_cubit.dart';
import 'package:marketplace/show_alert.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _surnameController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _lastNameController = TextEditingController();
    TextEditingController _organisationNameController = TextEditingController();
    TextEditingController _itinController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _password1Controller = TextEditingController();
    TextEditingController _password2Controller = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(waveLT, isAntiAlias: true, fit: BoxFit.contain),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.network(waveRB, isAntiAlias: true, fit: BoxFit.contain),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 83,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.33),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 62,
                        height: 62,
                        child: Image.network(logoPath, isAntiAlias: true, fit: BoxFit.contain),
                      ),
                      Container(width: 3),
                      const Text('Торги', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 47))
                    ],
                  ),
                ),
              ),
              Container(height: 20),
              const Text('Регистрация в качестве заказчика',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 35, color: Color.fromRGBO(49, 49, 49, 1))),
              Container(height: 20),
              Container(
                width: 1000,
                height: 550,
                padding: const EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(27),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RegistrationField(label: 'Фамилия', controller: _surnameController),
                        RegistrationField(label: 'Имя', controller: _nameController),
                        RegistrationField(label: 'Отчество', controller: _lastNameController),
                        RegistrationField(label: 'Название организации', controller: _organisationNameController),
                        RegistrationField(label: 'ИНН', controller: _itinController),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RegistrationField(label: 'Почта', controller: _emailController),
                        RegistrationField(label: 'Пароль', controller: _password1Controller, obscure: true),
                        RegistrationField(label: 'Повторите пароль', controller: _password2Controller, obscure: true),
                        const EmptyField(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                )),
                            Container(height: 10),
                            GestureDetector(
                              onTap: () {
                                if (_password1Controller.text != _password2Controller.text) {
                                  showAlert('Пароли не соврадают');
                                } else if (_surnameController.text.isEmpty) {
                                  showAlert('Фамилия не заполнена');
                                } else if (_nameController.text.isEmpty) {
                                  showAlert('Имя не заполнено');
                                } else if (_lastNameController.text.isEmpty) {
                                  showAlert('Отчество не заполно');
                                } else if (_organisationNameController.text.isEmpty) {
                                  showAlert('Название организации не заполнено');
                                } else if (_itinController.text.isEmpty) {
                                  showAlert('ИНН не заполнен');
                                } else {
                                  BlocProvider.of<RegisterCubit>(context).register(
                                      email: _emailController.text,
                                      password: _password1Controller.text,
                                      surname: _surnameController.text,
                                      name: _nameController.text,
                                      lastName: _lastNameController.text,
                                      organisationName: _organisationNameController.text,
                                      itin: _itinController.text);
                                }
                              },
                              child: Container(
                                height: 45,
                                width: 400,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(96, 89, 238, 1),
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Center(
                                  child: Text('Подтвердить заявку',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class RegistrationField extends StatelessWidget {
  const RegistrationField({Key? key, required this.controller, required this.label, this.obscure = false})
      : super(key: key);
  final TextEditingController controller;
  final String label;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
        Container(height: 10),
        Container(
          height: 45,
          width: 400,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(243, 243, 243, 1),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color.fromRGBO(153, 153, 153, 1),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EmptyField extends StatelessWidget {
  const EmptyField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            )),
        Container(height: 10),
        const SizedBox(
          height: 45,
          width: 400,
        ),
      ],
    );
  }
}
