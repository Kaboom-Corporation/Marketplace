import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/consts.dart';
import 'package:marketplace/pages/purchaser/auth/auth_cubit.dart';
import 'package:marketplace/router/purchaser_router.dart';
import 'package:marketplace/router/router.dart';
import 'package:video_player/video_player.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _vid2controller = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/feed-b1241.appspot.com/o/Comp_1-quicktime(2).mov?alt=media&token=d2ff8769-5052-4db7-8ed0-01f72780553a');

  @override
  void initState() {
    super.initState();

    _initVideos();
  }

  _initVideos() async {
    await _vid2controller.initialize();
    await _vid2controller.setVolume(0);
    await _vid2controller.setLooping(true);

    setState(() {});

    _vid2controller.play();
  }

  @override
  Widget build(BuildContext context) {
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
              const Text('Вход в кабинет заказчика',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 35, color: Color.fromRGBO(49, 49, 49, 1))),
              Container(height: 20),
              Container(
                width: 575,
                height: 380,
                padding: const EdgeInsets.all(30),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Логин (почта)',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
                    Container(height: 10),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: TextField(
                          controller: _mailController,
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
                    Container(height: 20),
                    const Text('Пароль',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
                    Container(height: 10),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
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
                    Container(height: 20),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<AuthCubit>(context).logIn(_mailController.text, _passwordController.text);
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(96, 89, 238, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Center(
                          child: Text(
                            'Войти',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: const Text(
                            'На гавную',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(181, 181, 181, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, purchaserPath + '/register');
                          },
                          child: const Text(
                            'Регистрация',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(96, 89, 238, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
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
