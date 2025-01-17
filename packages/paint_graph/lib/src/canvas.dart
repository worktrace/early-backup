import 'package:flutter/widgets.dart';

abstract class CanvasBase {
  const CanvasBase(this._canvas);

  @protected
  final Canvas _canvas;

  void drawRect(Rect rect, Paint paint);
}

class PaintCanvas extends CanvasBase {
  const PaintCanvas(super._canvas);

  @override
  void drawRect(Rect rect, Paint paint) => _canvas.drawRect(rect, paint);
}

class SVGCanvas extends CanvasBase {
  const SVGCanvas(super._canvas);

  @override
  void drawRect(Rect rect, Paint paint) {}
}
