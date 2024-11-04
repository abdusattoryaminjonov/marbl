import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:lottie/lottie.dart';

import '../../data/models/message_model.dart';
import '../controllers/home_controller.dart';

Widget itemOfGeminiMessage(MessageModel message, HomeController homeController,BuildContext context){

  return Container(
    constraints: const BoxConstraints(maxWidth: 300),
    padding:
    const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
    decoration: const BoxDecoration(
      color: Color.fromRGBO(184, 215, 207, 1.0),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4),
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    width: double.infinity,
    // padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(top: 15, bottom: 15),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 30,
                  child: Image.asset('assets/images/marbl_logo.png'),
                ),
                GestureDetector(
                  onTap: () {
                    homeController.speakTTS(message.message!);
                  },
                  child: const Icon(
                    Icons.volume_up,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 15),
                child: ParsedText(
                  text:message.message!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  parse: <MatchText>[

                    MatchText(
                      type: ParsedType.URL,
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                      onTap: (url) {
                        homeController.gotoIntranetPage(url,context);
                      },),
                    MatchText(
                      type: ParsedType.CUSTOM,
                      pattern: r"\*\*(.*?)\*\*",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      onTap: (url) {},),
                    MatchText(
                      type: ParsedType.CUSTOM,
                      pattern: r"```dart(.*?) \```",
                      style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 15,
                      ),
                      onTap: (url) {},),
                  ],
                )
            )
          ],
        ),
        homeController.isLoading ?  Container(
          width: 50,
          height: 50,
          child: Lottie.asset('assets/lotties/loading.json'),
        ) : const SizedBox.shrink()
      ],
    ),
  );
}