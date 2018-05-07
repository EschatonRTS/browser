import 'dart:html';
import 'package:eschaton/view.dart';

MapData mapData = new MapData(2, 2, [
  new Tile(0, 0, TileType.land),
  new Tile(0, 1, TileType.land1),
  new Tile(1, 0, TileType.land1),
  new Tile(1, 1, TileType.land),
]);

void main() {
  final el = document.body;
  MapView view = new MapView(mapData);

  el.children.add(view.el);
}
