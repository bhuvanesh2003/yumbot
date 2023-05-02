import 'package:edith/splash.dart';
import 'package:flutter/material.dart';
import 'chat/ui/chat_body.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Splash(),
        //'/welcome': (context) => const Welcome(),
        '/home': (context) => const ChatPage(),
      },
    );
  }
}
