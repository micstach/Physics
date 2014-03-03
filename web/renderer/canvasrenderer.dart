
import '../../math/vec2.dart';
import '../../math/box2.dart';
import '../../renderer/renderer.dart' ;

import 'dart:html';
import 'dart:math';

class CanvasRenderer extends Renderer
{
  final num TAU = PI * 2;
  
  CanvasElement _canvas = null ;
  CanvasRenderingContext2D _context = null ;
  
  CanvasRenderer(this._canvas)
  {
    _context = _canvas.context2D ;
  }

  Vec2 _convert(Vec2 p)
  {
    return new Vec2(p.x, _canvas.clientHeight - p.y) ;    
  }
  
  void clear()
  {
    _context.clearRect(0, 0, _canvas.clientWidth, _canvas.clientHeight);
  }
  
  void drawCircle(Vec2 p, double radius, String color)
  {
    var point = _convert(p) ;
    
    _context..beginPath()
           ..lineWidth = 2.0
           ..fillStyle = color 
           ..strokeStyle = color
           ..arc(point.x, point.y, radius.toInt(), 0, TAU, false)
           ..fill()
           ..closePath()
           ..stroke();
  }

  void drawPath(List<Vec2> points, bool close, String colorEven, String colorOdd) 
  {
    _context.strokeStyle = colorOdd ;
    
    var length = close ? points.length : points.length - 1 ;
    
    for (int i=0; i<length; i++)
    {
      var s = _convert(points[i]) ;
      var e = _convert(points[(i+1) % points.length]) ;

      _context..beginPath()
        ..lineWidth = 1.0
        ..strokeStyle = (i % 2 == 0 ? colorEven : colorOdd) 
        ..moveTo(s.x, s.y) 
        ..lineTo(e.x, e.y) 
        ..stroke() ;
    }
  }

  void drawVector(Vec2 vector, Vec2 origin, String color) 
  {
    var s = _convert(origin) ;
    var e = _convert(origin + vector) ;
    
    _context..beginPath()
     ..lineWidth = 3
     ..fillStyle = color
     ..strokeStyle = color
     ..lineTo(s.x, s.y)
     ..lineTo(e.x, e.y)
     ..fill()
     ..closePath()
     ..stroke();
  }

  void drawBox(Box2 b, String color)
  {
    drawPath(b.Points, true, color, color) ;
  }
}