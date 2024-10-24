import 'package:flutter/material.dart';
import 'package:pmproject/core/config/root_binding.dart';
import 'package:pmproject/presentation/pages/home_page.dart';
import 'package:get/get.dart';


import 'core/services/root_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RootService.init();
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: 'AIzaSyA-Xjc7gbOUTVKf5gmbqvmOUy34wMYbn6A',
  //       appId: '1:678415810955:android:1007369062ce7d1d266f8e',
  //       messagingSenderId: '678415810955',
  //       projectId: 'gemini-getx',
  //     )
  // );

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
      home: const HomePage(),
      initialBinding: RootBinding(),
      routes: {
        HomePage.id : (context) => const HomePage(),
      },
    );
  }
}
