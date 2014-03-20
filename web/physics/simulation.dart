library simulation ;

import "../../renderer/renderer.dart" ;
import "../../math/vec2.dart" ;
import "particle.dart" ;
import 'collisionmap.dart';
import 'collision.pair.dart';
import 'contact.dart';

import 'force.dart' ;
import 'force.gravity.dart' ;
import 'force.damping.dart' ;

import 'constraint.dart' ;

class Simulation
{
  int _worldWidth ;
  int _worldHeight ;
  
  double _dt = 0.0 ;

  List<Force> forces = new List<Force>() ;
  
  CollisionMap _collisionMap = null ;
  
  final Vec2 gravityForce = new Vec2(0.0, -0.0981) ;

  Simulation() 
  {
    forces.add(new Gravity(gravityForce)) ;
    forces.add(new Damping(0.999)) ;
  }

  set WorldWidth(int value) => _worldWidth = value ;
  set WorldHeight(int value) => _worldHeight = value ;
  
  bool get IsRunning => _dt > 0.0 ;
  
  void Start({double dt : 0.1}) 
  {
    _dt = dt ;
  }
  
  void Stop()
  {
    _dt = 0.0 ;
  }
       
  void _simulateParticle(Particle particle)
  {
    // action
    for (var force in forces)
    {
      force.Apply(particle) ;
    }
    
    particle.Integrate(_dt) ;
    
    // reaction
    _worldCollisionDetection(particle) ;  
  }
  
  void Simulate(List<Particle> particles, List<Constraint> constraints)
  {
    if (!IsRunning) return ;
    
    for (var particle in particles)
    {
      _simulateParticle(particle);
    }

    // resolve constraints
    int steps = 15 ;
    for (int i=0; i<steps; i++)
    {
      for (var constraint in constraints)
      {
        constraint.Resolve(i) ;
      }
    }

    // detect collisions
    CollisionMap collisions = _detectCollisions(particles) ;
    
    // resolve collisions
    _resolveCollisions(particles, collisions) ;
  }
  
  void _worldCollisionDetection(Particle particle)
  {
    if (particle.IsFixed) return ;
    
    // world box collisions detection
    int PARTICLE_RADIUS = particle.Radius.toInt() ;
    
    if (particle.Position.x > _worldWidth - PARTICLE_RADIUS)
    {
      particle.Velocity = Vec2.Reflect(particle.Velocity, new Vec2(-1.0, 0.0)).Neg();
      particle.Position = (new Vec2((_worldWidth - PARTICLE_RADIUS).toDouble(), particle.Position.y)) ;
    }
    
    if (particle.Position.x < 0.0 + PARTICLE_RADIUS)
    {
      particle.Velocity = Vec2.Reflect(particle.Velocity, new Vec2(1.0, 0.0)).Neg();
      particle.Position = (new Vec2((PARTICLE_RADIUS).toDouble(), particle.Position.y)) ;
    }
    
    if (particle.Position.y <= 0.0 + PARTICLE_RADIUS)
    {
      particle.Velocity = Vec2.Reflect(particle.Velocity, new Vec2(0.0, 1.0)).Neg();
      particle.Position = (new Vec2(particle.Position.x, 0.0 + PARTICLE_RADIUS)) ;
    }
    
    if (particle.Position.y > _worldHeight - PARTICLE_RADIUS)
    {
      particle.Velocity = Vec2.Reflect(particle.Velocity, new Vec2(0.0, -1.0)).Neg();
      particle.Position = (new Vec2(particle.Position.x, (_worldHeight - PARTICLE_RADIUS).toDouble())) ;
    }
  }

  CollisionMap _detectCollisions(List particles)
  {
    if (_collisionMap == null)
      _collisionMap = new CollisionMap(particles) ;
    else 
      _collisionMap.Update(particles) ;
    
    _collisionMap.Reset() ;
    
    for (CollisionPair pair in _collisionMap.Pairs)
    {
      pair.SetContact(Contact.Find(pair.A, pair.B)) ;
    }
    
    return _collisionMap;
  }

  void _resolveCollisions(List<Particle> particles, CollisionMap collisionMap)
  {
    // find "first-in-time" contacts
    for (Particle p in particles)
    {
      CollisionPair min = null ;
      List<CollisionPair> pairs = collisionMap.GetPairs(p) ;
      
      for (CollisionPair pair in pairs)
      {
        if (pair.GetContact() != null)
        {
          if (pair.GetContact().IsResting)
          {
          }
          else
          {
            if (min == null)
            {
              if (0.0 <= pair.GetContact().Dt && pair.GetContact().Dt < 1.0)
              {
                min = pair ;
              }
            }
            else
            {
              if (pair.GetContact().Dt < min.GetContact().Dt)
              {
                min.Discard() ;
                min = pair ;
              }
            }
          }
        }
      }
    }
    
    // resolve contacts
    for (CollisionPair pair in collisionMap.Pairs)
    {
      if (pair.GetContact() == null) continue ;
      
      pair.GetContact().Resolve(pair) ;
    }

    // iterative object separation
    for (int i=0; i<15; i++)
    {
      for (CollisionPair pair in collisionMap.Pairs)
      {
        if (pair.GetContact() == null) continue ;

        pair.GetContact().Separate(pair);
      }
    }
  }
  
  void Draw(List<Particle> particles, List<Constraint> constraints, Renderer renderer)
  {
    for (var particle in particles)
    {
      String color = "rgba(255, 128, 0, 0.75)" ;
      
      if (particle.IsFixed)
        color = "rgba(32, 32, 32, 0.5)" ;
      
      renderer.drawCircle(particle.Position, particle.Radius, color);
      
      // renderer.drawBox(particle.Box, "rgba(64, 64, 64, 1.0)") ;
      
      renderer.drawVector(particle.Velocity * 10.0, particle.Position, "rgba(255, 128, 0, 1.0)") ;
    }
    
    for (var constraint in constraints)
    {
      constraint.Render(renderer) ;
    }
  }
  
  CollisionMap get Collisions => _collisionMap ;
}
