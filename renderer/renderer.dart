library renderer ;

import '../math/vec2.dart' ;
import '../math/box2.dart' ;

abstract class Renderer
{
  void clear() ;
  
  void drawCircle(Vec2 center, double radius, String color) ;
  void drawPath(List<Vec2> path, bool close, String colorEven, String colorOdd) ;
  drawVector(Vec2 vector, Vec2 origin, String color) ;
  void drawBox(Box2 b, String color) ;
}