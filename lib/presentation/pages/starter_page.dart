import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/constants.dart';
import '../controllers/starter_controller.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  final starterController = Get.find<StarterController>();

  Future<bool> isConnectedToInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> checkInternetConnection(BuildContext context) async {
    bool isConnected = await isConnectedToInternet();
    if (!isConnected) {
      // Show an alert dialog if no internet connection is found
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    starterController.speakTTS(welcomingMessage);
  }

  @override
  void dispose() {
    starterController.stopTTS();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkInternetConnection(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
        child: Column(
          children: [
             Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Lottie.asset("assets/lotties/robot.json"),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: AnimatedTextKit(
                      repeatForever: false,
                      animatedTexts: [
                        TyperAnimatedText(
                          welcomingMessage,
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                          ),
                          speed: const Duration(milliseconds: 65),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                starterController.callGoogleSignIn();
              },
              child: Container(
                  height: 55,
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.black, // Set your border color here
                      width: 2.0, // Set the border width
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Open Chat",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
