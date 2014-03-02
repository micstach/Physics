library physics;

import 'dart:math';

class FixedParticle
{
  Point<double> _position ;  
  
  FixedParticle(this._position)
  { 
  }
  
  Point<double> get Position => _position ;
}