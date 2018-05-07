import 'dart:math';

class HexagonMeasure {
  double get width => _root3 * side;

  double get height => 2 * side;

  final double side;

  const HexagonMeasure(this.side);

  factory HexagonMeasure.fromWidth(double width) =>
      new HexagonMeasure(width / _root3);

  factory HexagonMeasure.fromHeight(double height) =>
      new HexagonMeasure(height / 2);

  static double _root3 = sqrt(3);
}
