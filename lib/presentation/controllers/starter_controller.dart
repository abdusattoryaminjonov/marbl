import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../core/services/auth_service.dart';
import '../pages/home_page.dart';

class StarterController extends GetxController{
  FlutterTts flutterTts = FlutterTts();

  callHomePage(BuildContext context){
    Navigator.pushReplacementNamed(context, HomePage.id);
  }


  callGoogleSignIn() async {
    var result = await AuthService.signInWithGoogle();
    Get.offNamed(HomePage.id);
  }

  Future speakTTS(String text) async {
    flutterTts.setSpeechRate(0.4);
    var result = await flutterTts.speak(text);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future stopTTS() async {
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }
}