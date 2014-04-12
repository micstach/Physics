library phx.contact;

import '../../math/vec2.dart';
import '../../math/quadric.dart';

import 'body.dart';
import 'metabody1d.dart' ;
import 'pair.dart';

class SeparateContact extends Contact
{
  SeparateContact(Body a, Body b, double collisionTime) : super(a, b, collisionTime) ;
  
  bool get IsResting => true ;
  
  void Separate()
  {
    Vec2 dp = B.Position - A.Position ;
    double len = dp.Length ;
    double diff = (A.Radius + B.Radius - len) ;
    
    if (diff <= 0.0) return ;

    Vec2 delta = dp * (diff / len) ;
    
    if (!A.IsFixed)
    {
      double s = A.MassInv / (A.MassInv + B.MassInv) ;

      A.PositionMove(delta * (-s)) ;
      A.VelocityMove(delta * (-s)) ;
    }
    
    if (!B.IsFixed)
    {
      double s = B.MassInv / (A.MassInv + B.MassInv) ;

      B.PositionMove(delta * s) ;
      B.VelocityMove(delta * s) ;
    }    
  }

  void Resolve(double dt, double e)
  {
    return ;
  }
  
  String get Name => "Separate" ;
}

class CollidingContact extends SeparateContact
{
  CollidingContact(Body a, Body b, double collisionTime) : super(a, b, collisionTime) 
  {
  }

  bool get IsResting => false ;

  double _impulse(double dt, double e, double relVel, double invMassA, double invMassB) 
  {
    return -((1.0 + e) / (dt * dt * 0.5)) * (relVel / (invMassA + invMassB)) ; 
  } 

  void Separate()
  {
  }
  
  void Resolve(double dt, double e)
  {
    A.ResetToCollisionTimePosition(dt) ;
    B.ResetToCollisionTimePosition(dt) ;

    Vec2 cn = (B.Position - A.Position).Normalize() ;
    
    double j = _impulse(dt, e, (cn | (B.Velocity - A.Velocity)), A.MassInv, B.MassInv) ;
    
    A.AddForce(cn * (-j), true) ;
    B.AddForce(cn * ( j), true) ;
    
    A.Integrate(dt, true) ;
    B.Integrate(dt, true) ;
  }
}

abstract class Contact extends Pair
{
  double _dt = 0.0 ;
  
  Contact(Body a, Body b, this._dt) : super(a, b) 
  {
  }

  double get Dt => _dt ;
  
  bool get IsResting ;
  
  String get Name => "Contact" ;
  
  void Resolve(double dt, double e) ;

  void Separate() ;
  
  static Contact Find(Body a, Body b)
  {
    if (!(a.Box * b.Box))
      return null ;

    var ap = a.Position;
    var bp = b.Position;
    
    double dp_final_len = (a.Position - b.Position).Length ;

    var av = a.Velocity ;
    var bv = b.Velocity ;

    // move particle position to previous step's position
    ap = ap - av;
    bp = bp - bv;
    
    // particle distance
    Vec2 dp = (bp - ap) ;
    double dp_len = dp.Length ;
    
    // contact normal
    Vec2 cn = dp * (1.0 / dp_len) ;
    
    // relativeVelocity
    Vec2 rv = (bv - av) ;

    // relative movement
    double rv_dot_cn = rv | cn ;
    
    const double THRESHOLD = 0.5 ;
    
    if (rv_dot_cn < -THRESHOLD)
    {
      // colliding contact
      var ea = rv.SqLength;
      var eb = 2.0 * ((dp.x * rv.x) + (dp.y * rv.y));
      var ec = dp.SqLength - ((a.Radius + b.Radius) * (a.Radius + b.Radius)) ;

      Quadric eq = new Quadric(ea, eb, ec) ;
      
      if (eq.IsSolvable)
      {
        double x = eq.x ;
        if (0.0 <= x && x <= 1.0)
        {
          return new CollidingContact(a, b, x) ;
        }
      }
    }
    
    if (dp_final_len <= (a.Radius + b.Radius))
    {
      return new SeparateContact(a, b, 0.0) ;
    }
    
    return null ;
  }
}