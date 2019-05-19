import 'package:flutter/material.dart';
import 'package:game_2048/model/model.dart';
import 'package:game_2048/widgets/board_widget.dart';

import '../utils.dart';

class TileWidget extends StatefulWidget {
  Tile tile;
  BoardWidgetState boardWidgetState;

  TileWidget({Key key}) : super(key: key);

  _TileWidgetState createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    animation = Tween(begin: .0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    widget.tile.isNew = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tile.isNew && !widget.tile.isEmpty()) {
      controller.reset();
      controller.forward();
      widget.tile.isNew = false;
    } else {
      controller.animateTo(1.0);
    }
    return AnimatedTileWidget(
      tile: widget.tile,
      state: widget.boardWidgetState,
      animation: animation,
    );
  }
}

class AnimatedTileWidget extends AnimatedWidget {
  final Tile tile;
  final BoardWidgetState state;

  AnimatedTileWidget(
      {Key key, this.tile, this.state, Animation<double> animation})
      : super(
          key: key,
          listenable: animation,
        );
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    double animationValue = animation.value;
    Size boardSize = state.boardSize();
    double width = (boardSize.width - (state.column + 1) * state.tilePadding) /
        state.column;

    if (tile.value == 0) return Container();

    return Positioned(
      left: (tile.column * width + state.tilePadding * (tile.column + 1)) +
          width / 2 * (1 - animationValue),
      top: tile.row * width +
          state.tilePadding * (tile.row + 1) +
          width / 2 * (1 - animationValue),
      child: Container(
        width: width * animationValue,
        height: width * animationValue,
        decoration:
            BoxDecoration(color: tileColors[tile.value] ?? Colors.orange[50]),
        child: Center(
          child: Text(tile.value.toString()),
        ),
      ),
    );
  }
}
