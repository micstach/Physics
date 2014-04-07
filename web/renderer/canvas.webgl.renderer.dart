library canvas.webgl.renderer ;

import '../../math/vec2.dart';
import '../../math/box2.dart';
import '../../renderer/renderer.dart' ;

import 'dart:html';

class CanvasWebGLRenderer extends Renderer
{
  CanvasWebGLRenderer(CanvasElement canvas)
  {
  }
  
  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  void drawBox(Box2 b, String color) {
    // TODO: implement drawBox
  }

  @override
  void drawCircle(Vec2 center, double radius, String color) {
    // TODO: implement drawCircle
  }

  @override
  drawLine(Vec2 a, Vec2 b, String color) {
    // TODO: implement drawLine
  }

  @override
  void drawPath(List<Vec2> path, bool close, String colorEven, String colorOdd) {
    // TODO: implement drawPath
  }

  @override
  drawVector(Vec2 vector, Vec2 origin, String color) {
    // TODO: implement drawVector
  }
}