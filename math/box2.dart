library math.box2 ;

import 'dart:math' ;
import 'vec2.dart' ;

class Box2
{
  Vec2 _min ;
  Vec2 _max ;
  
  List<Vec2> _points = null ;
  
  Box2(Vec2 p, Vec2 v)
  {
    Vec2 e = p + v ;
    _min = new Vec2(min(p.x, e.x), min(p.y, e.y)) ;
    _max = new Vec2(max(p.x, e.x), max(p.y, e.y)) ;
    
    _rebuildPoints() ;
  }
  
  Box2 Extend(double r)
  {
    r = (r < 0.0) ? -r : r ;
    
    Vec2 t = new Vec2(r, r) ;
    
    _min -= t ;
    _max += t ;
    
    _rebuildPoints() ;
    
    return this ;
  }
  
  Box2 Translate(Vec2 t)
  {
    _min += t ;
    _max += t ;
    
    _rebuildPoints() ;
    
    return this ;
  }
  
  bool operator * (Box2 b)
  {
    return this.Intersect(b) ;
  }
  
  bool Intersect(Box2 b)
  {
    if (_max.x < b._min.x)
      return false ;
    else if (b._max.x < _min.x)
      return false ;
    else if (_max.y < b._min.y)
      return false ;
    else if (b._max.y < _min.y)
      return false ;

    return true ;
  }
  
  List<Vec2> get Points => _points ;
  
  void _rebuildPoints()
  {
    _points = [new Vec2.fromVec2(_min), new Vec2(_min.x, _max.y), new Vec2.fromVec2(_max), new Vec2(_max.x, _min.y)] ;
  }
}