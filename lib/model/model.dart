import 'dart:math';

class Board {
  final int row;
  final int column;
  int score;

  Board(this.row, this.column);

  List<List<Tile>> _tiles;

  void initTiles() {
    _tiles = List.generate(
        4,
        (row) => List.generate(
            4,
            (col) => Tile(
                  row: row,
                  column: col,
                  isNew: false,
                  canMerge: false,
                )));
    score = 0;
  }

  Tile getTile(int r, int c) => _tiles[r][c];

  void randomEmptyTile() {
    List<Tile> empty = [];
    _tiles.forEach((row) {
      empty.addAll(row.where((tile) => tile.isEmpty()));
    });

    if(empty.isEmpty) return;

    Random rnd = Random();

    for(int i; i < 4; i++) {
      int index = rnd.nextInt(empty.length);
      empty[index].value = rnd.nextInt(9) == 0 ? 4 : 2;
      empty[index].isNew = true;
      empty.removeAt(index);
    }

  }
}

class Tile {
  int row, column;
  int value;
  bool canMerge;
  bool isNew;

  Tile({this.row, this.value = 0, this.column, this.canMerge, this.isNew});

  bool isEmpty() => value == 0;

  @override
  int get hashCode => value.hashCode;

  @override
  operator ==(other) => other is Tile && value == other.value;
}
