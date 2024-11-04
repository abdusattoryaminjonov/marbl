import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pmproject/core/config/root_binding.dart';
import 'package:pmproject/presentation/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:pmproject/presentation/pages/starter_page.dart';


import 'core/services/root_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RootService.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDG_f29okp5yiGAxiBzdxEa0m83wvD2gRo',
        appId: '1:676420517900:android:9a15dd34d3af56e4352e29',
        messagingSenderId: '676420517900',
        projectId: 'marblai',
      )
  );




  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StarterPage(),
      initialBinding: RootBinding(),
      routes: {
        HomePage.id : (context) => const HomePage(),
      },
    );
  }
}
