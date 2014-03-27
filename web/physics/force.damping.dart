library pxh.force.damping ;

import 'particle.dart' ;
import 'force.dart' ;

class Damping extends Force
{
  double _factor = 1.0 ;
  
  Damping(double factor)
  {
    _factor = (factor < 0.0) ? -factor : factor ;
    
    if (_factor > 1.0) _factor = 1.0 ;
    if (_factor < 0.0) _factor = 0.0 ;
  }
  
  void Apply(Particle particle) 
  {
    particle.AddForce(particle.Velocity * (-_factor)) ;
  }
}
