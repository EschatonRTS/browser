import "dart:math";

enum HexDirection { w, nw, ne, e, se, sw }

class Hex {
  final int q;

  final int r;

  Hex(this.q, this.r);

  int get s => -q - r;

  int distance(Hex other) {
    var a = (q - other.q).abs();
    var b = (r - other.r).abs();
    var c = (a - b).abs();
    return max(a, max(b, c));
  }

  Hex neighbor(HexDirection direction) {
    return this + directions[direction.index];
  }

  bool operator ==(Object other) =>
      other is Hex && q == other.q && r == other.r;

  Hex operator +(Hex other) {
    return new Hex(q + other.q, r + other.r);
  }

  Hex operator -(Hex other) {
    return new Hex(q - other.q, r - other.r);
  }

  Hex operator *(int k) => new Hex(q * k, r * k);

  @override
  toString() => "($q, $r)";

  static List directions = [
    new Hex(-1, 0),
    new Hex(0, -1),
    new Hex(1, -1),
    new Hex(1, 0),
    new Hex(0, 1),
    new Hex(-1, 1),
  ];
}