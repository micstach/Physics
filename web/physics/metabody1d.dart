library phxmetabody ;

import '../../renderer/renderer.dart' ;
import '../../math/vec2.dart' ;
import '../../math/box2.dart';

import 'body.dart' ;

class MetaBody1D extends Body
{
  Body _a = null, _b = null;

  double _f = 0.0 ;
  
  MetaBody1D(this._a, this._b, this._f) : super() 
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
  Vec2 get Velocity => (_a.Velocity * _f + _b.Velocity * (1.0 - _f)) ;

  @override
  Vec2 get Position => (_a.Position * _f + _b.Position * (1.0 - _f)) ;
  
  @override
  double get Radius => (_a.Radius * _f + _b.Radius * (1.0 - _f)) ;
  
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
      _a.AddForce(force * _f, propagate) ;
      _b.AddForce(force * (1.0 - _f), propagate) ;
    }
  }  
  
  @override
  Box2 get Box => new Box2(Position - Velocity, Velocity).Extend(Radius) ; 
  
  toJSON()
  {
    return {
      'type': 'metabody1d',
      'a': _a.hashCode,
      'b': _b.hashCode,
      'f': _f,
      'hash-code': hashCode 
    };
  }

  @override
  bool IsRelatedTo(Body body) {
  
    if (body is MetaBody1D)
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
  double get MassInv => (_a.MassInv * _f + _b.MassInv * (1.0 - _f));

  @override
  set Position(Vec2 value) {
    if (!_a.IsFixed)
      _a.Position = value * _f ;
    if (!_b.IsFixed)
      _b.Position = value * (1.0 - _f) ;
  }

  @override
  set Velocity(Vec2 value) {
    if (!_a.IsFixed)
      _a.Velocity = value * _f ;
    if (!_b.IsFixed)
      _b.Velocity = value * (1.0 - _f) ;
  }

  @override
  void PositionMove(Vec2 delta) {
    if (!_a.IsFixed)
      _a.PositionMove(delta * _f) ;
    if (!_b.IsFixed)
      _b.PositionMove(delta * (1.0 - _f)) ;
  }

  @override
  void VelocityMove(Vec2 delta) {
    if (!_a.IsFixed)
      _a.VelocityMove(delta * _f) ;
    if (!_b.IsFixed)
      _b.VelocityMove(delta * (1.0 - _f)) ;
  }
}