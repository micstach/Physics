library phxsuperparticle ;

import '../../renderer/renderer.dart' ;
import '../../math/vec2.dart' ;
import '../../math/box2.dart';

import 'particle.dart' ;
import 'body.dart' ;

class SuperParticle extends Body
{
  Particle _a = null ;
  double _af = 0.0 ;
 
  Particle _b = null ;
  double _bf = 0.0 ;
  
  SuperParticle(this._a, this._af, this._b, this._bf) : super() 
  {
  }
  
  void Render(Renderer renderer)
  {
    renderer.drawCircle(Position, Radius, "rgba(0,0,128, 0.5)") ;
  }
  
  @override 
  void AddForce(Vec2 force) {} 
  
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
  void Integrate(double dt) { } 
  
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
    return (body == _a || body == _b) ;
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
      _a.Position += delta * _af ;
    if (!_b.IsFixed)
      _b.Position += delta * _bf ;
  }

  @override
  void VelocityMove(Vec2 delta) {
    if (!_a.IsFixed)
      _a.Velocity += delta * _af ;
    if (!_b.IsFixed)
      _b.Velocity += delta * _bf ;
  }
}