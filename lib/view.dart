import 'dart:html';
import 'hexagon.dart';

abstract class CustomElement {
  Element get el;
}

String px(num v) => '${v.toInt()}px';

class TileView implements CustomElement {
  final Tile tile;

  TileType get type => tile.type;

  int get column => tile.column;

  int get row => tile.row;

  HexagonMeasure measure;

  final Element el = new Element.div();

  TileView(this.tile, this.measure) {
    el
      ..classes.add('hex-tile')
      ..style.width = px(measure.width)
      ..style.height = px(measure.height)
      ..style.left = px(left)
      ..style.top = px(top)
      ..children.add(new DivElement()
        ..classes.add('hex-tile-part')
        ..classes.add('hex-tile-part-center')
        ..style.width = px(measure.width)
        ..style.height = px(measure.side))
      ..children.add(new DivElement()
        ..classes.add('hex-tile-part')
        ..classes.add('hex-tile-part-up')
        ..style.width = px(measure.width)
        ..style.height = px(measure.side))
      ..children.add(new DivElement()
        ..classes.add('hex-tile-part')
        ..classes.add('hex-tile-part-down')
        ..style.width = px(measure.width)
        ..style.height = px(measure.side));
  }

  double get left {
    if (row.isEven) return column * measure.width;
    return (column * measure.width) + (measure.width / 2);
  }

  double get top {
    return row * (measure.height * 0.75);
  }

  _onMouseOver(MouseEvent event) {
    // TODO
  }
}

class MapView implements CustomElement {
  final MapData data;

  int get numCols => data.columns;

  int get numRows => data.rows;

  final List<TileView> tiles = <TileView>[];

  MapView(this.data) {
    el..classes.add('map');

    for(int r = 0; r < data.rows; r++) {
      for(int c = 0; c < data.columns; c++) {
        Tile tile = data.get(c, r);

        TileView tv = new TileView(tile, measure);
        tiles.add(tv);
        el.children.add(tv.el);
      }
    }
  }

  final DivElement el = new DivElement();

  final measure = new HexagonMeasure.fromWidth(64.0);
}

class TileType {
  final int id;
  final String name;
  final bool goW;
  final bool goNW;
  final bool goNE;
  final bool goE;
  final bool goSE;
  final bool goSW;
  final bool stopW;
  final bool stopNW;
  final bool stopNE;
  final bool stopE;
  final bool stopSE;
  final bool stopSW;

  const TileType({
    this.id,
    this.name,
    this.goW: true,
    this.goNW: true,
    this.goNE: true,
    this.goE: true,
    this.goSE: true,
    this.goSW: true,
    this.stopW: true,
    this.stopNW: true,
    this.stopNE: true,
    this.stopE: true,
    this.stopSE: true,
    this.stopSW: true,
  });

  static const TileType water = const TileType(id: 0, name: "Water");
  static const TileType water1 = const TileType(id: 1, name: "Water 1");
  static const TileType water2 = const TileType(id: 2, name: "Water 2");
  static const TileType bridgeHorizontal =
  const TileType(id: 10, name: "Horizontal bridge");
  static const TileType bridgeVertical =
  const TileType(id: 20, name: "Vertical bridge");
  static const TileType bridgeToEast =
  const TileType(id: 30, name: "Bridge to east");
  static const TileType bridgeToWest =
  const TileType(id: 40, name: "Bridge to west");
  static const TileType land = const TileType(id: 50, name: "Land");
  static const TileType land1 = const TileType(id: 51, name: "Land 1");
  static const TileType land2 = const TileType(id: 52, name: "Land 2");
  static const TileType forrest = const TileType(id: 60, name: "Forrest");
  static const TileType forrest1 = const TileType(id: 61, name: "Forrest 1");
  static const TileType swamp = const TileType(id: 70, name: "Swamp");
  static const TileType mountain = const TileType(id: 80, name: "Mountain");
}

class Tile {
  final int column;

  final int row;

  final TileType type;

  const Tile(this.column, this.row, this.type);
}

class MapData {
  final int columns;

  final int rows;

  final List<Tile> tiles;

  const MapData(this.columns, this.rows, this.tiles);

  Tile get(int column, int row) {
    assert(column >= 0 && column < columns);
    assert(row >= 0 && row < rows);
    return tiles[(row * columns) + column];
  }
}