import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:clock/StopwatchClass.dart';
import 'package:clock/CountdownTimer.dart';

class Clock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            StopwatchClass(),
            CountdownTimer(),
          ],
        ),
        bottomNavigationBar: Material(
          color: Colors.black,
          child: TabBar(
            labelColor: Colors.grey,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.watch_later),
                child: Text(
                  'Stopwatch',
                ),
              ),
              Tab(
                icon: Icon(Icons.timer),
                child: Text(
                  'Timer',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}