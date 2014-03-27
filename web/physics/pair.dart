library phx.pair ;

import 'particle.dart' ;

abstract class Pair
{
  Particle _a ;
  Particle _b ;
  
  Pair(this._a, this._b) ;
  
  Particle get A => _a ;
  Particle get B => _b ;
}