import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/timePicker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeOfDay time = const TimeOfDay(hour: 0, minute: 1);
  late int maxTime = time.hour * 60 + time.minute;
  Timer? timer;
  bool isActive = false;

  void showTimer() async {
    TimeOfDay? seconds = await showDialog(
      context: context,
      builder: (context) => Time(time: time),
    );
    setState(() {
      time = seconds!;
      maxTime = time.hour * 60 + time.minute;
    });
  }

  @override
  void initState() {
    restart();
    super.initState();
  }

  void startTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (maxTime > 0) {
        setState(() {
          maxTime--;
        });
        isActive = true;
      } else {
        stopTime();
      }
    });
  }

  void restart() {
    setState(() {
      maxTime = 0;
      stopTime();
    });
  }

  void stopTime() {
    setState(() {
      timer?.cancel();
    });
    isActive = false;
  }

  double get value => maxTime / (time.hour * 60 + time.minute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          children: [
            Center(
              child: Image(
                width: 80,
                height: 80,
                image: AssetImage("assets/images/flutterbro.png"),
              ),
            ),
            SizedBox(width: 15),
            Text(
              "@flutter.bro",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF071952),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Center(
              child: Text(
                "TIMER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey,
                    color: Colors.white,
                  ),
                  TextButton(
                    onPressed: showTimer,
                    child: Text(
                      "${"${maxTime ~/ 60}".padLeft(2, "0")}:${"${maxTime % 60}".padLeft(2, "0")}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                          color: Colors.white),
                    ),
                  ),

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: restart,
                  icon: const Icon(
                    CupertinoIcons.repeat,
                    size: 30,
                  ),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: !isActive ? startTime : stopTime,
                  icon: Icon(
                    !isActive ? Icons.play_arrow : Icons.pause,
                    size: 50,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    maximumSize: const Size(80, 80),
                    backgroundColor: const Color(0xFF35A29F),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.bell,
                    size: 30,
                  ),
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
