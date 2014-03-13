library particle ;

import '../../math/vec2.dart';
import '../../math/box2.dart';

class Particle 
{
  Vec2 _position ;
  Vec2 _velocity = new Vec2(0.0, 0.0);
  Vec2 _acceleration = new Vec2(0.0, 0.0);
  Vec2 _force = new Vec2(0.0, 0.0);
  
  Box2 _velocityBox = null ;
  
  Box2 _largeBox = null ;
  
  double _damping = 0.990 ;
  double _radius = 10.0 ;
  double _mass = double.INFINITY ;
  
  void _initializeBox()
  {
    _velocityBox = new Box2(_position - _velocity, _velocity).Extend(_radius) ;
  }
  
  Particle.fromParticle(Particle particle)
  {
    Position = particle.Position ;
    Velocity = particle.Velocity ;
    _force = particle._force ;
    Mass = particle.Mass;
    
    _initializeBox();
  }
  
  Particle.fromVec2(Vec2 position)
  {
    Position = position ;
   
    _initializeBox();
  }

  Particle(double x, double y)
  { 
    _position = new Vec2(x, y);
    
    _initializeBox() ;
  }
  
  Vec2 get Position => _position ;
  
  set Position(Vec2 value) => _position = value ; 
  
  set Velocity(Vec2 value) => _velocity = value ;
  Vec2 get Velocity => _velocity ;
  
  set Mass(double value) => _mass = value;
  double get Mass => _mass ;
  
  bool get IsFixed => _mass == double.INFINITY;
  
  double get MassInv { return IsFixed ? 0.0 : 1.0/_mass ; }
  
  double get Radius => _radius ;
  
  Box2 get Box => _velocityBox ; 
  
  void AddForce(Vec2 force)
  {
    if (!IsFixed)
      _force += force ;
  }
  
  void Integrate(double dt)
  {
    if (IsFixed) return ;
    
    _acceleration = _force * MassInv ;
    
    Vec2 oldPosition = _position ;
    
    _position += (_velocity * _damping) + _acceleration * (dt * dt * 0.5) ;
    
    _velocity = (_position - oldPosition) ;
    
    _initializeBox() ;
    
    _force.Zero();
  }
}
