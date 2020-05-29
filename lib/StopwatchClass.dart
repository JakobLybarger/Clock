import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:clock/Lap.dart';


class StopwatchClass extends StatefulWidget {
  @override
  _StopwatchClassState createState() => _StopwatchClassState();
}

class _StopwatchClassState extends State<StopwatchClass> {
  bool start = true;
  bool stop = true;
  bool reset = true;
  RunState state = RunState.original;
  String time = '00:00:00';
  int lap = 1;
  List<Lap> laps = List<Lap>();
  Stopwatch watch = Stopwatch();
  final duration = const Duration(seconds: 1);

  void initializeTimer() {
    Timer(duration, keepRunning);
  }

  void keepRunning() {
    if (watch.isRunning) {
      initializeTimer();
    }

    setState(() {
      time = watch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (watch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (watch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startWatch() {
    setState(() {
      state = RunState.running;
      stop = false;
      start = false;
    });
    watch.start();
    initializeTimer();
  }

  void stopWatch() {
    setState(() {
      state = RunState.paused;
      stop = true;
      reset = false;
      start = true;
    });
    watch.stop();
  }

  void resetWatch() {
    setState(() {
      state = RunState.original;
      reset = true;
    });
    watch.reset();
    time = '00:00:00';
    laps.removeWhere((item) => item.lapNumber > 0);
    lap = 1;
  }

  void newLap(){
    laps.add(Lap(lap, time));
    lap++;
  }

  @override
  Widget build(BuildContext context) {

    double buttonTextSize = MediaQuery.of(context).size.width / 17;

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      time,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width / 7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: laps.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Lap' + laps[index].lapNumber.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: MediaQuery.of(context).size.width / 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 5
                                  ),
                                  Text(
                                    laps[index].time,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                                height: 5,
                                thickness: 1,
                                indent: 20,
                                endIndent: 0,
                              ),
                            ],
                          )
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (state == RunState.original)
                        ButtonBar(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){},
                              child: ClipOval(
                                child: Container(
                                  color: Colors.grey,
                                  height: MediaQuery.of(context).size.width / 5,
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Center(
                                    child: Text(
                                      'Lap',
                                      style: TextStyle(
                                        fontSize: buttonTextSize,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                            ),
                            GestureDetector(
                              onTap: startWatch,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.green,
                                  height: MediaQuery.of(context).size.width / 5,
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Center(
                                    child: Text(
                                      'Start',
                                      style: TextStyle(
                                        fontSize: buttonTextSize,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      if(state == RunState.running)
                        ButtonBar(
                          children: <Widget>[
                            GestureDetector(
                              onTap: newLap,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.grey,
                                  height: MediaQuery.of(context).size.width / 5,
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Center(
                                    child: Text(
                                      'Lap',
                                      style: TextStyle(
                                        fontSize: buttonTextSize,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                            ),
                            GestureDetector(
                              onTap: stopWatch,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.red,
                                  height: MediaQuery.of(context).size.width / 5,
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Center(
                                    child: Text(
                                      'Stop',
                                      style: TextStyle(
                                        fontSize: buttonTextSize,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      if(state == RunState.paused)
                        ButtonBar(
                          children: <Widget>[
                            GestureDetector(
                              onTap: resetWatch,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.grey,
                                  height: MediaQuery.of(context).size.width / 5,
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Center(
                                    child: Text(
                                      'Reset',
                                      style: TextStyle(
                                        fontSize: buttonTextSize,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                            ),
                            GestureDetector(
                              onTap: startWatch,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.green,
                                  height: MediaQuery.of(context).size.width / 5,
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Center(
                                    child: Text(
                                      'Start',
                                      style: TextStyle(
                                        fontSize: buttonTextSize,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

enum RunState {
  original,
  paused,
  running
}
