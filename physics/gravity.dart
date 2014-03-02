library force.gavity ;

import '../math/vec2.dart' ;

import 'force.dart' ;
import 'particle.dart' ;

class Gravity extends Force
{
  Vec2 _force = null ;

  Gravity(this._force) ;
  
  void Apply(Particle particle) 
  {
    particle.AddForce(_force * particle.Mass) ;
  }
}
