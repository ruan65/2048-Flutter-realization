import 'package:flutter/material.dart';
import 'package:game_2048/model/model.dart';
import 'package:game_2048/widgets/tile_widget.dart';

import '../main.dart';

class BoardWidget extends StatefulWidget {
  BoardWidget({Key key}) : super(key: key);

  BoardWidgetState createState() => BoardWidgetState();
}

class BoardWidgetState extends State<BoardWidget> {
  Board _board = Board();
  int row = 4;
  int column = 4;
  bool _isMoving = false;
  bool gameOver = false;
  MediaQueryData _mediaQueryData;

  double tilePadding = 5.0;

  @override
  void initState() {
    super.initState();
    newGame();
  }

  newGame() {
    setState(() {
      _board.initBoard();
    });
  }

  Size boardSize() {
    Size size = _mediaQueryData.size;
    return Size(size.width, size.width);
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    List<TileWidget> _tileWidgets = List.generate(4, (row) {
      List.generate(4, (col) {
        return TileWidget(
            tile: _board.getTile(row, col), boardWidgetState: this);
      });
    });

    List<Widget> children = [];
    children.add(HomePage(state: this));
    children.addAll(_tileWidgets);

    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                color: Colors.orange[100],
                width: 120,
                height: 60,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Score: '),
                      Text(_board.score.toString()),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
