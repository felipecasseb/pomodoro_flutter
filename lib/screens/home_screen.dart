import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/ui/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int time = 25;
  int breakTime = 5;
  Timer? timer;
  int counter = 25 * 60;
  double? valueProgress = 0;
  bool? trabalhar;

  void _startTimer(int timeInMinutes) {
    counter = timeInMinutes * 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          counter--;
          if (trabalhar!) {
            valueProgress = counter / 1500;
          } else {
            valueProgress = counter / 300;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: const Text("Pomodoro Flutter"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 10,
              width: MediaQuery.of(context).size.width / 3,
              child: LinearProgressIndicator(
                value: valueProgress!,
                backgroundColor: Colors.white,
                color: const Color(0xFF6492e8),
              )),
          Text(
            "${counter ~/ 60 < 10 ? "0${counter ~/ 60}" : counter ~/ 60}:${counter % 60 < 10 ? "0${counter % 60}" : counter % 60}",
            style: TextStyle(
                color: Colors.white,
                fontSize: max(120, MediaQuery.of(context).size.width / 8)),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RawMaterialButton(
                onPressed: () {
                  setState(() {
                    if (timer != null) {
                      timer!.cancel();
                    }
                    trabalhar = true;
                  });
                  _startTimer(25);
                },
                fillColor: AppColor.secondaryColor,
                shape: const StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 64),
                child: const Text(
                  "Trabalhar",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              RawMaterialButton(
                onPressed: () {
                  setState(() {
                    if (timer != null) {
                      timer!.cancel();
                    }
                    trabalhar = false;
                  });
                  _startTimer(5);
                },
                fillColor: AppColor.secondaryColor,
                shape: const StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 64),
                child: const Text(
                  "Cafezinho",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          RawMaterialButton(
            onPressed: () {
              setState(() {
                if (timer != null) {
                  timer!.cancel();
                }
              });
            },
            fillColor: Colors.redAccent,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 64),
            child: const Text(
              "Parar",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
