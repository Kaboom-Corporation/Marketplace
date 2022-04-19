import 'package:flutter/material.dart';
import 'package:marketplace/consts.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _surnameController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _lastNameController = TextEditingController();
    TextEditingController _organisationNameController = TextEditingController();
    TextEditingController _itinController = TextEditingController();
    TextEditingController _loginController = TextEditingController();
    TextEditingController _password1Controller = TextEditingController();
    TextEditingController _password2Controller = TextEditingController();

    return Scaffold(
      body: Column(
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
                    child: Image.asset(logoPath, isAntiAlias: true, fit: BoxFit.contain),
                  ),
                  Container(width: 3),
                  const Text('Торги', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 47))
                ],
              ),
            ),
          ),
          Container(height: 20),
          const Text('Регистрация',
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
                    RegistrationField(label: 'Логин', controller: _loginController),
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
                        Container(
                          height: 45,
                          width: 400,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(96, 89, 238, 1), borderRadius: BorderRadius.circular(12)),
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
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
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
