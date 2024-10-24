import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmproject/core/services/auth_service.dart';
import 'package:pmproject/presentation/controllers/home_controller.dart';

import '../widgets/item_marbl_massage.dart';
import '../widgets/item_user_massage.dart';

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

    // TODO: qimirlatish orqali api ga so'rov jo'natiish
    // ShakeDetector.autoStart(
    //   onPhoneShake: () {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text('Shake!'),
    //       ),
    //     );
    //   },
    //   minimumShakeCount: 1,
    //   shakeSlopTimeMS: 500,
    //   shakeCountResetTime: 3000,
    //   shakeThresholdGravity: 2.7,
    // );
  }

  @override
  void dispose() {
    homeController.textEditingController.dispose();
    homeController.textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: GetBuilder<HomeController>(
            builder: (_){
              return Container(
                padding: EdgeInsets.only(bottom: 20,top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              child: Image(
                                image: AssetImage('assets/images/marbl_logo.png'),
                                fit: BoxFit.cover,
                              ),
                            )
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
                                padding: EdgeInsets.only(top: 10,right: 16),
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
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(15),
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
                    Container(),
                  ],
                ),
              );
            },
          ),
        )
    );
  }



  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       leading: Container(
  //         margin: EdgeInsets.only(left: 10),
  //           height: 50,
  //           width: 50,
  //           child: Image(image: AssetImage("assets/images/marbl_logo.png"),)),
  //       title: Text("Marbl",style: TextStyle(fontFamily: 'CustomFont',fontSize: 24.0,),),
  //       actions: [
  //         GestureDetector(
  //           onTap: (){
  //             // homeController.logOutDialog(context);
  //           },
  //           child: Container(
  //             padding: const EdgeInsets.only(top: 10, right: 16),
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(20.0),
  //               child: Container(
  //                 height: 40,
  //                   width: 40,
  //                   child: Image(image: AssetImage("assets/images/ic_person.png"),)),
  //               // child: CachedNetworkImage(
  //               //   height: 40,
  //               //   width: 40,
  //               //   imageUrl: AuthService.currentUser().photoURL!,
  //               //   placeholder: (context, url) => const Image(
  //               //     image: AssetImage(
  //               //         "assets/images/ic_person.png"),
  //               //     width: 70,
  //               //     height: 70,
  //               //     fit: BoxFit.cover,
  //               //   ),
  //               //   errorWidget: (context, url, error) => const Image(
  //               //     image: AssetImage(
  //               //         "assets/images/ic_person.png"),
  //               //     width: 70,
  //               //     height: 70,
  //               //     fit: BoxFit.cover,
  //               //   ),
  //               // ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     body: Column(
  //       children: [
  //         Expanded(
  //             child: Container(
  //               margin: const EdgeInsets.all(15),
  //               child: Text("mmm")
  //             )),
  //       ],
  //     ),
  //   );
  // }
}
