import 'package:firebase_storage/firebase_storage.dart';

const String logoPath = 'Logo_3.png';
const String logoUrlPath = 'https://firebasestorage.googleapis.com/v0/b/market-20e57.appspot.com/o/Logo_3.png?alt=media&token=320986f4-2f33-4730-b396-0d06c8ced059';
const String redWaveUrl = 'https://firebasestorage.googleapis.com/v0/b/market-20e57.appspot.com/o/red_vawe.gif?alt=media&token=6f951c02-c2c4-4553-898a-991ad09abc36';
const String blueWaveUrl = 'https://firebasestorage.googleapis.com/v0/b/market-20e57.appspot.com/o/blue_wave.gif?alt=media&token=578517a8-a961-4aea-bf32-d661a0392e57';
final storageRef = FirebaseStorage.instanceFor().ref();