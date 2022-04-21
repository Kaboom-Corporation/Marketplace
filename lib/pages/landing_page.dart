import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/consts.dart';
import 'package:marketplace/router/purchaser_router.dart';
import 'package:marketplace/router/router.dart';
import 'package:marketplace/router/supplier_router.dart';
import 'package:video_player/video_player.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool vidInited = false;

  @override
  void initState() {
    initChew();

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  initChew() async {
    videoPlayerController = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/market-20e57.appspot.com/o/Gotovy_produkt.mp4?alt=media&token=dbee6650-963d-485e-8001-41e240ee7379');

    await videoPlayerController.initialize();

    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
        autoInitialize: true,
        maxScale: 1,
        errorBuilder: (c, s) => Center(
              child: GestureDetector(
                onTap: () {
                  chewieController = ChewieController(
                      videoPlayerController: videoPlayerController,
                      overlay: Container(),
                      autoPlay: false,
                      looping: true,
                      autoInitialize: true,
                      errorBuilder: (c, s) => Center(
                            child: GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.settings_backup_restore_rounded),
                            ),
                          ));
                },
                child: const Icon(Icons.settings_backup_restore_rounded, color: Color.fromRGBO(215, 59, 29, 1)),
              ),
            ));

    setState(() {
      vidInited = true;
    });
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
            children: [
              Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.33),
                        blurRadius: 10,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 55,
                        height: 55,
                        child: Image.network(logoPath, isAntiAlias: true, fit: BoxFit.contain),
                      ),
                      Container(width: 3),
                      const Text('Торги', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35)),
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(supplierPath);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(96, 89, 238, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Я - исполнитель',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      Container(width: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(purchaserPath);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(96, 89, 238, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Я - заказчик',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  child: Center(
                child: vidInited
                    ? SizedBox(
                        height: 700,
                        width: 1000,
                        child: Chewie(
                          controller: chewieController,
                        ),
                      )
                    : Container(),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
