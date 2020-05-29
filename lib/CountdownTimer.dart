import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


class CountdownTimer extends StatefulWidget {

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<CountdownTimer> with TickerProviderStateMixin {

  int _hour = 0;
  int _minute = 0;
  int _second = 0;
  bool start = true;
  bool stop = true;
  int timerTimeInSeconds = 0;
  String timeDisplay;
  bool checkTimer = true;

  void timerStart() {
    setState(() {
      start = false;
      stop = false;
    });
    timerTimeInSeconds = _hour * 60 * 60 + _minute * 60 + _second;
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if(timerTimeInSeconds < 1 || checkTimer == false){
          t.cancel();
          checkTimer = true;
          timeDisplay = '';
          start = true;
          stop = true;
        }
        else if(timerTimeInSeconds < 60) {
          timeDisplay = timerTimeInSeconds.toString();
          timerTimeInSeconds = timerTimeInSeconds - 1;
        }
        else if(timerTimeInSeconds < 3600) {
          int m = timerTimeInSeconds ~/ 60;
          int s = timerTimeInSeconds - (60 * m);
          timeDisplay = m.toString().padLeft(2, '0') + ':' + s.toString().padLeft(2, '0');
          timerTimeInSeconds = timerTimeInSeconds - 1;
        }
        else {
          int h = timerTimeInSeconds ~/ 3600;
          int t = timerTimeInSeconds - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timeDisplay = h.toString().padLeft(2, '0') + ':' +
                          m.toString().padLeft(2, '0') + ':' +
                          s.toString().padLeft(2, '0');
        }
      });
    });
  }

  void timerStop() {
    setState(() {
      start = true;
      stop = true;
      checkTimer = false;
      timeDisplay = '';
    });
  }


  @override
  Widget build(BuildContext context) {
    double buttonTextSize = MediaQuery.of(context).size.width / 17;

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Hours'),
                  NumberPicker.integer(
                    initialValue: _hour,
                    minValue: 0,
                    maxValue: 23,
                    onChanged: (value) => setState(() {
                      _hour = value;
                    }),
                    infiniteLoop: true,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('Minutes'),
                  NumberPicker.integer(
                    initialValue: _minute,
                    minValue: 0,
                    maxValue: 59,
                    onChanged: (value) => setState(() {
                      _minute = value;
                    }),
                    infiniteLoop: true,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('Seconds'),
                  NumberPicker.integer(
                    initialValue: _second,
                    minValue: 0,
                    maxValue: 59,
                    onChanged: (value) => setState(() {
                      _second = value;
                    }),
                    infiniteLoop: true,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Expanded(
            flex: 1,
            child: Text(
              timeDisplay != null ? timeDisplay : '',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 10,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: timerStop,
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
                GestureDetector(
                  onTap: timerStart,
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
          ),
        ],
      ),
    );
  }
}