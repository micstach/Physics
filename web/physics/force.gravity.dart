library pxh.force.gavity ;

import '../math/vec2.dart' ;

import 'force.dart' ;
import 'body.dart' ;

class Gravity extends Force
{
  Vec2 _force = null ;

  Gravity(this._force) ;
  
  void Apply(Body body) 
  {
    double dt = 0.1;
    
    body.AddForce(_force * body.Mass * (1.0 / (dt * dt))) ;
  }
}
