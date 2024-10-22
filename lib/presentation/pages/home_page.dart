import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 10),
            height: 50,
            width: 50,
            child: Image(image: AssetImage("assets/images/marbl_logo.png"),)),
        title: Text("Marbl",style: TextStyle(fontFamily: 'CustomFont',fontSize: 24.0,),),
        actions: [
          GestureDetector(
            onTap: (){
              // homeController.logOutDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.only(top: 10, right: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 40,
                    width: 40,
                    child: Image(image: AssetImage("assets/images/ic_person.png"),)),
                // child: CachedNetworkImage(
                //   height: 40,
                //   width: 40,
                //   imageUrl: AuthService.currentUser().photoURL!,
                //   placeholder: (context, url) => const Image(
                //     image: AssetImage(
                //         "assets/images/ic_person.png"),
                //     width: 70,
                //     height: 70,
                //     fit: BoxFit.cover,
                //   ),
                //   errorWidget: (context, url, error) => const Image(
                //     image: AssetImage(
                //         "assets/images/ic_person.png"),
                //     width: 70,
                //     height: 70,
                //     fit: BoxFit.cover,
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                margin: const EdgeInsets.all(15),
                child: ,
              )),
        ],
      ),
    );
  }
}
