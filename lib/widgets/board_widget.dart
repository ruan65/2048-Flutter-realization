import 'package:flutter/material.dart';
import 'package:game_2048/model/model.dart';

class BoardWidget extends StatefulWidget {
  BoardWidget({Key key}) : super(key: key);

  BoardWidgetState createState() => BoardWidgetState();
}

class BoardWidgetState extends State<BoardWidget> {

  Board _board = Board();
  bool _isMoving = false;
  bool _gameOver = false;
  MediaQueryData _mediaQueryData;

  double tilePadding = 5.0;

  @override
  void initState() { 
    super.initState();
    newGame();
  }

  newGame() {
    setState(() {
      _gameOver = false;
      _board.initBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    return Container(
       
    );
  }

  Size boardSize() {
    Size size = _mediaQueryData.size;
  }
}