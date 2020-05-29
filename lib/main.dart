import 'package:flutter/material.dart';

import 'package:clock/Clock.dart';

main() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock',
      theme: _theme(context),
      home: Clock(),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _theme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.grey,
      textTheme: TextTheme(

      ),
    );
  }
}