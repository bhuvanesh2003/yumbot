import 'dart:async';
import 'package:edith/chat/ui/chat_body.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
//import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late VideoPlayerController _controller;
  static const splashDuration = Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/yummy.mp4')
      ..initialize().then((_) {
        setState(() {}); // rebuild the widget tree after initialization
        _controller.play(); // start playing the video
      });
  }

  @override
  void dispose() {
    _controller
        .dispose(); // dispose the controller when the widget is removed from the tree
    super.dispose();
  }

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  startTimer();
}
  /*void initState_1() {
    super.initState();
    startTimer();
  }*/

  startTimer() {
    return Timer(splashDuration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ChatPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter,
          colors: [
            Color(0xff343541),Color(0xff444654)
          ])
        ),
        child: content()),
    );
  }

  Widget content() {
    return Center(
      child: Container(
        child: AspectRatio(
            aspectRatio: _controller
                .value.aspectRatio, // set the aspect ratio of the video
            child: VideoPlayer(_controller)),
      ),
    );
  }
}
