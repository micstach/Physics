library contact;

import '../../math/vec2.dart';
import '../../math/quadric.dart';

import 'particle.dart';
import 'collision.pair.dart';

class SeparateContact extends Contact
{
  SeparateContact(Vec2 cn, double rv_dot_cn) : super(0.0, cn, null, rv_dot_cn) ;
  
  bool get IsResting => true ;
  
  String get Name => "Separate" ;
  
  void Resolve(CollisionPair pair)
  {
    return ;
  }
  
  void Separate(CollisionPair pair)
  {
    var a = pair.A ;
    var b = pair.B ;
    
    Vec2 dp = b.Position - a.Position ;
    double len = dp.Length ;
    double diff = (a.Radius + b.Radius - len) ;
    
    if (diff >= 0.0)
    {
      Vec2 delta = dp * ((diff / len) * 0.5) ;
      
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

  void ProjectVelocity(CollisionPair pair)
  {
    var a = pair.A ;
    var b = pair.B ;
    
    Vec2 dp = b.Position - a.Position ;
    dp.Normalize() ;

    double rv_dot_cn = (b.Velocity - a.Velocity) | dp ;
    
    double j = Contact.Impulse(0.1, 0.0, rv_dot_cn, a.MassInv, b.MassInv);
    
    if (rv_dot_cn < 0.0)
    {
      a.AddForce(dp * j) ;
      b.AddForce(dp * (-j)) ;
    }
//    if (super._rv_dot_cn < 0.0)
//    {
//      var a = pair.A ;
//      var b = pair.B ;
//      
//      a.Velocity = Vec2.Project(a.Velocity, super._cn);
//      b.Velocity = Vec2.Project(b.Velocity, super._cn);
//    }
  }
}

class RestingContact extends SeparateContact
{
  RestingContact() : super(null, 0.0) ;
  
  bool get IsResting => true ;
  
  String get Name => "Resting" ;

  void Resolve(CollisionPair pair)
  {
    return ;
  }
  
  void ProjectVelocity(CollisionPair pair)
  {
    return ;
  }
}

class CollidingContact extends Contact
{
  CollidingContact(double dt, Vec2 cn, Vec2 rv, double rv_dot_cn) : super(dt, cn, rv, rv_dot_cn) ;

  bool get IsResting => false ;
  
  void Separate(CollisionPair pair)
  {
    return ;
  }
  
  void Resolve(CollisionPair pair)
  {
    var a = pair.A ;
    var b = pair.B ;
    
    a.Position += a.Velocity * (-1.0 + super.Dt) ; 
    b.Position += b.Velocity * (-1.0 + super.Dt) ;
    
    double j = Contact.Impulse(0.1, 0.75, super._rv_dot_cn, a.MassInv, b.MassInv) ;
    
    a.AddForce(super._cn * j) ;
    b.AddForce(super._cn * (-j)) ;
    
    a.Integrate(0.1) ;
    b.Integrate(0.1) ;
  }
  
  void ProjectVelocity(CollisionPair pair)
  {
    return ;
  }
}

abstract class Contact
{
  double _dt ;
  double _rv_dot_cn = 0.0 ;

  Vec2 _cn = null;
  Vec2 _rv = null;
  
  Contact(this._dt, this._cn, this._rv, this._rv_dot_cn) 
  {
  }

  double get Dt => _dt ;
  
  bool get IsResting ;
  
  String get Name => "Contact" ;
  
  void Resolve(CollisionPair pair) ;
  
  void Separate(CollisionPair pair) ;
  
  void ProjectVelocity(CollisionPair pair) ;
  
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
    Vec2 cn = (new Vec2(dp.x, dp.y)).Normalize() ;
    
    // relativeVelocity
    Vec2 rv = (bv - av) ;

    // relative movement
    double rv_dot_cn = rv | cn ;
    
    const double THRESHOLD = 0.000000001 ;
    
    if (rv_dot_cn < -THRESHOLD)
    {
      // colliding contact
      var ea = rv.SqLength;
      var eb = 2.0 * ((dp.x * rv.x) + (dp.y * rv.y));
      var ec = dp.SqLength - ((a.Radius + b.Radius) * (a.Radius + b.Radius)) ;

      Quadric eq = new Quadric(ea, eb, ec) ;
      
      if (eq.IsSolvable)
      {
        if (0.0 <= eq.x && eq.x <= 1.0)
        {
          return new CollidingContact(eq.x, cn, rv, rv_dot_cn) ;
        }
      }
    }
    else if (rv_dot_cn <= THRESHOLD)
    {
      if (dp.Length <= (a.Radius + b.Radius))
      {
        return new RestingContact() ;
      }      
    }
    
    if (dp.Length <= (a.Radius + b.Radius))
    {
      return new SeparateContact(cn, rv_dot_cn) ;
    }
    
    return null ;
  }

  static double Impulse(double dt, double e, double relVel, double invMassA, double invMassB) 
  {
    return ((1.0 + e) / (dt * dt * 0.5)) * (relVel / (invMassA + invMassB)) ; 
  } 
}