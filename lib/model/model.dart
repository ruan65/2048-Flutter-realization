class Board {
  final int row;
  final int column;
  int score;

  Board(this.row, this.column);
}

class Tile {
  int row, column;
  int value;
  bool canMerge;
  bool isNew;

  Tile({this.row, this.value = 0, this.column, this.canMerge, this.isNew});

  bool isEmpty () =>  value == 0;

  @override
  int get hashCode => value.hashCode;

  @override
  operator ==(other) => other is Tile && value == other.value;

}
