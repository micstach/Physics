library contact;

import '../../math/vec2.dart';
import '../../math/quadric.dart';

//import 'simulation.dart' ;
import 'particle.dart';

class SeparateContact extends Contact
{
  SeparateContact() : super(0.0) ;
  
  bool get IsResting => true ;
  
  void Resolve(Particle a, Particle b)
  {
    a.IsResting = true ;
    b.IsResting = true ;

    Vec2 dp = b.Position - a.Position ;
    double len = dp.Length ;
    
    if (len <= (a.Radius + b.Radius))
    {
      Vec2 delta = dp * ((a.Radius + b.Radius - len) / len) * 0.5 ;
      
      if (!a.IsFixed)
      {
        a.Position -= delta ;
      }
      
      if (!b.IsFixed)
      {
        b.Position += delta ;
      }    
    }
  }
}

class CollidingContact extends Contact
{
  CollidingContact(double dt) : super(dt) ;

  bool get IsResting => false ;
  
  void Resolve(Particle a, Particle b)
  {
    a.Position = a.Position + a.Velocity * (-1.0 + super.Dt) ; 
    b.Position = b.Position + b.Velocity * (-1.0 + super.Dt) ;
    
    Vec2 rv = b.Velocity - a.Velocity ;
    Vec2 cn = (b.Position - a.Position).Normalize() ;
    
    double factor = (rv | cn) ;
    
    if (factor <= 0.0)
    {
      double j = Contact.Impulse(0.1, 0.5, factor, a.MassInv, b.MassInv) ;
      
      a.AddForce(cn * j) ;
      b.AddForce(cn * (-j)) ;
      
      a.IsResting = false ;
      b.IsResting = false ;
    }
  }
}

class RestingContact extends Contact
{
  RestingContact(double dt) : super(dt) ;
  
  bool get IsResting => true ;
  
  void Resolve(Particle a, Particle b)
  {
    return ;
//    Particle p = (!a.IsFixed) ? a : b ;
//    
//    Vec2 cn = (b.Position - a.Position).Normalize() ;
//    
//    p.Position = p.Position - p.Velocity ;
//    p.Velocity.Zero() ;
        
    //p.AddForce(cn * 2.5) ;
    
  }
}

abstract class Contact
{
  double _dt ;

  Contact(this._dt) 
  {
  }

  double get Dt => _dt ;
  
  bool get IsResting ;
  
  void Resolve(Particle a, Particle b) ;
  
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
          return new CollidingContact(eq.x) ;
        }
        else if (0.0 <= eq.y && eq.y <= 1.0 && eq.y < eq.x)
        {
          return new CollidingContact(eq.y) ;
        }
      }
      
      if (dp.Length <= (a.Radius + b.Radius))
      {
        return new SeparateContact() ;
      }      
    }
    else if (rv_dot_cn < THRESHOLD)
    {
      if (dp.Length <= (a.Radius + b.Radius))
      {
        return new SeparateContact() ;
      }  
      
      //      // colliding contact
//      var ea = rv.SqLength;
//      var eb = 2.0 * ((dp.x * rv.x) + (dp.y * rv.y));
//      var ec = dp.SqLength - ((a.Radius + b.Radius) * (a.Radius + b.Radius)) ;
//
//      Quadric eq = new Quadric(ea, eb, ec) ;
//      
//      if (eq.IsSolvable)
//      {
//        if (0.0 <= eq.x && eq.x <= 1.0 && eq.x < eq.y)
//        {
//          return new RestingContact(eq.x) ;
//        }
//        else if (0.0 <= eq.y && eq.y <= 1.0 && eq.y < eq.x)
//        {
//          return new RestingContact(eq.y) ;
//        }
//      }
    }
    
    


    return null ;
  }

  static double Impulse(double dt, double e, double relVel, double invMassA, double invMassB) 
  {
    return ((1.0 + e) / (dt * dt * 0.5)) * (relVel / (invMassA + invMassB)) ; 
  } 
}