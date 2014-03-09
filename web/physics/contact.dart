library contact;

import '../../math/vec2.dart';
import '../../math/quadric.dart';

import 'particle.dart';

class Contact
{
  Particle _a ;
  Particle _b ;
  
  double _dt ;
  bool _resting = false ;
  
  bool get IsResting => _resting ;
  
  Contact(this._a, this._b, this._dt) 
  {
    _resting = false ;
  }
  
  double get Dt => _dt ;
  
  static Contact Find(Particle a, Particle b)
  {
    if (a.IsFixed && b.IsFixed)
      return null ;
    
    if (!(a.Box * b.Box))
      return null ;

    var ap = a.Position;
    var bp = b.Position;

    var av = a.Velocity ;
    var bv = b.Velocity ;

    // move particle position to previous step's position
    ap = ap - av;
    bp = bp - bv;
    
    // particle distance
    Vec2 dp = (bp - ap) ;

    // contact normal
    var cn = dp ;
    
    // relativeVelocity
    var rv = (bv - av) ;

    // relative movement
    var rv_dot_cn = rv | cn ;
    
    const double THRESHOLD = 0.0001 ;
    
    if (rv_dot_cn < -THRESHOLD)
    {
      // colliding contact
      var ea = rv.SqLength;
      var eb = 2.0 * ((dp.x * rv.x) + (dp.y * rv.y));
      var ec = dp.SqLength - ((a.Radius + b.Radius) * (a.Radius + b.Radius)) ;

      Quadric eq = new Quadric(ea, eb, ec) ;
      
      if (eq.IsSolvable)
      {
        if (0.0 <= eq.x && eq.x <= 1.0 && eq.x < eq.y)
        {
          return new Contact(a, b, eq.x) ;
        }
        else if (0.0 <= eq.y && eq.y <= 1.0 && eq.y < eq.x)
        {
          return new Contact(a, b, eq.y) ;
        }
      }
    }
    else if (rv_dot_cn <= 0.0)
    {
      var contact = new Contact(a, b, 0.0) ;
      contact._resting = true ;
      
      return contact ;
    }

    return null ;
  }
  
  Particle get A => _a ;
  Particle get B => _b ;
  
}