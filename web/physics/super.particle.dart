library phxmetabody ;

import '../../renderer/renderer.dart' ;
import '../../math/vec2.dart' ;
import '../../math/box2.dart';

import 'body.dart' ;

class SuperParticle extends Body
{
  Body _a = null ;
  double _af = 0.0 ;
 
  Body _b = null ;
  double _bf = 0.0 ;
  
  SuperParticle(this._a, this._af, this._b, this._bf) : super() 
  {
  }
  
  void Render(Renderer renderer)
  {
    renderer.drawCircle(Position, Radius, "rgba(0, 0, 128, 0.5)") ;
  }
  
  @override
  double get Mass => 1.0 ; 
      
  @override
  bool get IsFixed => false ;

  @override
  Vec2 get Velocity => (_a.Velocity * _af + _b.Velocity * _bf) ;

  @override
  Vec2 get Position => (_a.Position * _af + _b.Position * _bf) ;
  
  @override
  double get Radius => (_a.Radius * _af + _b.Radius * _bf ) ;
  
  @override
  void Integrate(double dt, [bool propagate = false]) 
  { 
    if (propagate)
    {
      _a.Integrate(dt, propagate) ;
      _b.Integrate(dt, propagate) ;
    }
  }
  
  @override 
  void AddForce(Vec2 force, [bool propagate = false]) 
  {
    if (propagate)
    {
      _a.AddForce(force * _af, propagate) ;
      _b.AddForce(force * _bf, propagate) ;
    }
  }  
  
  @override
  Box2 get Box => new Box2(Position - Velocity, Velocity).Extend(Radius) ; 
  
  toJSON()
  {
    return {
      'a': _a.hashCode,
      'b' : _b.hashCode,
      'af' : _af,
      'bf' : _bf
    };
  }

  @override
  bool IsRelatedTo(Body body) {
  
    if (body is SuperParticle)
    {
      // (?) same parents
      return (((body._a == _a) && (body._b == _b))  || ((body._b == _a) && (body._a == _b)));
    }
    else
    {
      // (?) this is child of body
      return (body == _a || body == _b) ;
    }
  }

  @override
  double get MassInv => (_a.MassInv * _af + _b.MassInv * _bf);

  @override
  set Position(Vec2 value) {
    if (!_a.IsFixed)
      _a.Position = value * _af ;
    if (!_b.IsFixed)
      _b.Position = value * _bf ;
  }

  @override
  set Velocity(Vec2 value) {
    if (!_a.IsFixed)
      _a.Velocity = value * _af ;
    if (!_b.IsFixed)
      _b.Velocity = value * _bf ;
  }

  @override
  void PositionMove(Vec2 delta) {
    if (!_a.IsFixed)
      _a.PositionMove(delta * _af) ;
    if (!_b.IsFixed)
      _b.PositionMove(delta * _bf) ;
  }

  @override
  void VelocityMove(Vec2 delta) {
    if (!_a.IsFixed)
      _a.VelocityMove(delta * _af) ;
    if (!_b.IsFixed)
      _b.VelocityMove(delta * _bf) ;
  }
}