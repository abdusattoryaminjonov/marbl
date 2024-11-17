import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmproject/core/services/auth_service.dart';
import 'package:pmproject/presentation/controllers/home_controller.dart';
import 'package:shake/shake.dart';

import '../../core/constants/constants.dart';
import '../../core/services/utils_service.dart';
import '../widgets/item_marbl_massage.dart';
import '../widgets/item_user_massage.dart';
import 'package:flutter_tts/flutter_tts.dart';


class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.initSTT();
    homeController.uploadData();

    ShakeDetector.autoStart(
      onPhoneShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            width: 200,
            content:  Container(
                child: Center(child: Text(shakeMessage))
            ),
            behavior: SnackBarBehavior.floating, // Optional: positions SnackBar above the bottom
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.black12,
          ),

        );
        homeController.speakTTS(shakeMessage);
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }

  @override
  void dispose() {
    homeController.textController.dispose();
    homeController.textFieldFocusNode.dispose();
    homeController.stopTTS();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: GetBuilder<HomeController>(
            builder: (_){
              return Container(
                padding: const EdgeInsets.only(bottom: 20,top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              child: const Image(
                                image: AssetImage('assets/images/marbl_logo.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Text("Marbl",style: TextStyle(
                              fontFamily:'CustomFont',
                              fontSize: 26,
                            ),)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: (){
                                homeController.logOutDialog(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 10,right: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: CachedNetworkImage(
                                    height: 40,
                                    width: 40,
                                    imageUrl: AuthService.currentUser().photoURL!,
                                    placeholder: (context,url) => const Image(image: AssetImage('assets/images/user_icon.png'),
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) => const Image(
                                      image: AssetImage(
                                          "assets/images/user_icon.png"),
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                        child: homeController.messages.isEmpty
                        ? Center(
                          child: SizedBox(
                            width: 70,
                            child: Image.asset(
                                'assets/images/marbl_logo.png'),
                          ),
                        ) :ListView.builder(
                            itemCount: homeController.messages.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                            homeController.messages[index];
                            if (message.isMine!) {
                              return itemOfUserMessage(message);
                            } else {
                              return itemOfGeminiMessage(message, homeController,context);
                            }
                          },
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(right: 20, left: 20),
                      padding: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          homeController.pickedImage == null
                              ? const SizedBox.shrink()
                              : Container(
                            margin: const EdgeInsets.only(top: 15),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                Utils.base64Decode(
                                    homeController.pickedImage!
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: homeController.textController,
                                  maxLines: null,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Message',
                                    hintStyle: TextStyle(color: Colors.black38),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  homeController.onSelectedImage();
                                },
                                icon: const Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: Colors.black,
                                ),
                              ),
                              // if (homeController.textController.text
                              //     .isEmpty) // Show icons only if text is empty
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  homeController.speechToText.isNotListening
                                      ? homeController.startSTT()
                                      : homeController.stopSTT();
                                },
                                icon: const Icon(
                                  Icons.mic,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  var text = homeController.textController.text
                                      .toString()
                                      .trim();
                                  homeController.onSendPressed(text);
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
    );
  }
}
