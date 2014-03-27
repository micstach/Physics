library math.quadric ;

import 'dart:math';

class Quadric
{
  double _a ;
  double _b ;
  double _c ;
  double _d = -1.0;
  double _x, _y ;
  
  Quadric(this._a, this._b, this._c) 
  {
    if (_a != 0.0)
    {
      _d = (_b * _b) - (4.0 * _a * _c) ;
      
      if (_d > 0.0)
      {
        var d = sqrt(_d) ;
        var k = 1.0 / (2.0 * _a) ;
        
        _x = (-_b - d) * k ;
        _y = (-_b + d) * k ;
      }
      else if (_d == 0.0)
      {
        _x = -_b / (2.0 * _a) ;
        _y = _x ;
      }
    }
  }
  
  bool get IsSolvable => (_d >= 0.0) ;
  
  double get x => _x ;
  double get y => _y ;
}