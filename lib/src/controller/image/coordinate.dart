class Coordinate {
  Coordinate(this.x, this.y);
  Coordinate.from(Coordinate c) : this(c.x, c.y);
  int x;
  int y;

  Coordinate operator +(Coordinate other) {
    return Coordinate(x + other.x, y + other.y);
  }

  bool insideOf(int top, int left, int bottom, int right) {
    if (top <= y && left <= x && y <= bottom && x <= right) return true;
    return false;
  }

  @override
  String toString() {
    return '($x,$y)';
  }
}
