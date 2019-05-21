import 'package:flutter/material.dart';
import 'package:game_2048/widgets/board_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048 game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  final BoardWidgetState state;

  const HomePage({Key key, this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
