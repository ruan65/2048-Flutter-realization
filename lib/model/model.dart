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

    if (empty.isEmpty) return;

    Random rnd = Random();

    for (int i; i < 4; i++) {
      int index = rnd.nextInt(empty.length);
      empty[index].value = rnd.nextInt(9) == 0 ? 4 : 2;
      empty[index].isNew = true;
      empty.removeAt(index);
    }
  }

  void mergeLeft(int row, int col) {
    while (col > 0) {
      merge(_tiles[row][col - 1], _tiles[row][col]);
      col--;
    }
  }

  void mergeRight(int row, int col) {
    while (col < column - 1) {
      merge(_tiles[row][col + 1], _tiles[row][col]);
      col++;
    }
  }

  void mergeUp(int row, int col) {
    while (row > 0) {
      merge(_tiles[row - 1][col], _tiles[row][col]);
      row--;
    }
  }

  void mergeDown(int row, int col) {
    while (row < this.row - 1) {
      merge(_tiles[row + 1][col], _tiles[row][col]);
      row++;
    }
  }

  void moveLeft() {
    if (!canMoveLeft()) return;

    for (int r = 0; r < row; r++) {
      for (int c = 1; c < column; c++) {
        mergeLeft(r, c);
      }
    }
    randomEmptyTile();
    resetCamMerge();
  }

  void moveRight() {
    if (!canMoveRight()) return;

    for (int r = 0; r < row; r++) {
      for (int c = column -1; c > 0; c--) {
        mergeRight(r, c);
      }
    }
    randomEmptyTile();
    resetCamMerge();
  }

  void moveUp() {
    if (!canMoveUp()) return;

    for (int r = 1; r < row; r++) {
      for (int c = 0; c < column; c++) {
        mergeUp(r, c);
      }
    }
    randomEmptyTile();
    resetCamMerge();
  }

  void moveDown() {
    if (!canMoveDown()) return;

    for (int r = row - 1; r > 0; r--) {
      for (int c = 0; c < column; c++) {
        mergeDown(r, c);
      }
    }
    randomEmptyTile();
    resetCamMerge();
  }

  bool canMoveLeft() {
    for (int r = 0; r < row; r++) {
      for (int c = 1; c < column; c++) {
        if (canMerge(_tiles[r][c], _tiles[r][c - 1])) {
          return true;
        }
      }
    }
    return false;
  }

  bool canMoveRight() {
    for (int r = 0; r < row; r++) {
      for (int c = column - 1; c > 0; c--) {
        if (canMerge(_tiles[r][c], _tiles[r][c + 1])) {
          return true;
        }
      }
    }
    return false;
  }

  bool canMoveUp() {
    for (int r = 1; r < row; r++) {
      for (int c = 0; c < column; c++) {
        if (canMerge(_tiles[r - 1][c], _tiles[r][c])) {
          return true;
        }
      }
    }
    return false;
  }

  bool canMoveDown() {
    for (int r = row - 1; r > 0; r--) {
      for (int c = 0; c < column; c++) {
        if (canMerge(_tiles[r][c], _tiles[r + 1][c])) {
          return true;
        }
      }
    }
    return false;
  }

  bool canMerge(Tile a, Tile b) =>
      !a.canMerge &&
      ((b.isEmpty() && !a.isEmpty()) && (!a.isEmpty() && a == b));

  void resetCamMerge() {
    _tiles.forEach((col) {
      col.forEach((t) => t.canMerge = false);
    });
  }

  void merge(Tile a, Tile b) {
    if (!canMerge(a, b)) {
      if (!a.isEmpty() && !b.canMerge) {
        b.canMerge = true;
      }
      return;
    }

    if (b.isEmpty()) {
      b.value = a.value;
      a.value = 0;
    } else if (a == b) {
      b.value = b.value * 2;
      a.value = 0;
      b.canMerge = true;
    } else {
      b.canMerge = true;
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
