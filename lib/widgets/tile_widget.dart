import 'package:flutter/material.dart';
import 'package:game_2048/model/model.dart';
import 'package:game_2048/widgets/board_widget.dart';

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

  AnimatedTileWidget({this.tile, this.state, Animation<double> animation})
      : super(listenable: animation);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
