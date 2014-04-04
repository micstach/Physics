library phx.particle ;

import '../../math/vec2.dart';
import '../../math/box2.dart';
import '../../renderer/renderer.dart' ;

import 'Body.dart' ;

class Particle extends Body
{
  Vec2 _position ;
  Vec2 _velocity = new Vec2(0.0, 0.0);
  Vec2 _acceleration = new Vec2(0.0, 0.0);
  Vec2 _force = new Vec2(0.0, 0.0);
  
  Box2 _velocityBox = null ;
  
  Box2 _largeBox = null ;
  
  double _radius = 10.0 ;
  double _mass = double.INFINITY ;
  bool _resting = false ;
  
  void _initializeBox()
  {
    _velocityBox = new Box2(_position - _velocity, _velocity).Extend(_radius) ;
  }
  
  Particle.fromParticle(Particle particle)
  {
    Position = particle.Position ;
    Velocity = particle.Velocity ;
    _force = particle._force ;
    _radius = particle._radius ;
    Mass = particle.Mass;
    
    _initializeBox();
  }
  
  Particle.fromJSON(json)
  {
    Position = new Vec2.fromJSON(json['position']) ;
    Velocity = new Vec2.fromJSON(json['velocity']) ;

    _radius = json['radius'] ;

    double massInv = json['mass-inv'] ;
    Mass = massInv == 0.0 ? double.INFINITY : 1.0 / massInv ;
    
    _initializeBox();
  }
  
  Particle.fromVec2(Vec2 position, [double r])
  {
    _radius = r ;
    Position = position ;
   
    _initializeBox();
  }

  Particle(double x, double y, [double r])
  { 
    if (r != null)
      _radius = r ;
    
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
  
  bool get IsResting => _resting ;
  set IsResting(bool resting) => _resting = resting ;
  
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
    
    _acceleration = (_force * MassInv) * (dt * dt * 0.5) ;

    _position += _acceleration + _velocity;
    
    _velocity += _acceleration ;
    
    _initializeBox() ;
    
    _force.Zero();
  }
  
  toJSON()
  {
    return {
      'position': {'x': Position.x, 'y': Position.y},
      'velocity' : {'x' : Velocity.x, 'y': Velocity.y},
      'radius': Radius,
      'mass-inv': MassInv,
      'hash-code': hashCode
    };
  }
  
  void Render(Renderer renderer)
  {
    String color ;
    
    if (IsFixed)
    {
      color = "rgba(0, 0, 0, 0.5)" ;
    }
    else
    {
      int massColor = (255.0 * MassInv).toInt() ;
      color = "rgba(${massColor}, 0, 0, 0.75)" ;
    }
    
    renderer.drawCircle(Position, Radius, color);
  }
}
