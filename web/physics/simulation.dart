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

  List<Force> _forces = new List<Force>() ;
  
  CollisionMap _collisionMap = null ;
  
  final Vec2 gravityForce = new Vec2(0.0, -0.0981) ;

  Simulation() 
  {
    _forces.add(new Gravity(gravityForce)) ;
    
    _forces.add(new Damping(0.999)) ;
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
    for (var force in _forces)
    {
      force.Apply(particle) ;
    }
    
    particle.Integrate(_dt) ;
  }
  
  void Simulate(List<Particle> particles, List<Constraint> constraints)
  {
    if (!IsRunning) return ;
    
    for (var particle in particles)
    {
      _simulateParticle(particle);
    }

    // detect collisions
    List<CollisionPair> pairs = _detectCollisions(particles, constraints) ;
    
    // resolve collisions
    _resolveCollisions(particles, constraints, pairs) ;

    for (var particle in particles)
    {
      _worldCollisionDetection(particle) ;
    }
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

  List<CollisionPair> _detectCollisions(List<Particle> particles, List<Constraint> constraints)
  {
    // refresh collision map
    if (_collisionMap == null)
      _collisionMap = new CollisionMap(particles, constraints) ;
    else 
      _collisionMap.Update(particles, constraints) ;
    
    _collisionMap.Reset() ;
    
    List<CollisionPair> pairs = new List<CollisionPair>() ;
    
    for (CollisionPair pair in _collisionMap.Pairs)
    {
      Contact contact = Contact.Find(pair.A, pair.B) ;
      if (contact != null)
      {
        pair.SetContact(contact) ;
        pairs.add(pair) ;
      }
    }
    
    return pairs ;
  }

  void _resolveCollisions(List<Particle> particles, List<Constraint> constraints, List<CollisionPair> pairs)
  {
    // find "first-in-time" contacts
//    for (Particle p in particles)
//    {
//      CollisionPair min = null ;
//      List<CollisionPair> pairs = collisionMap.GetPairs(p) ;
//      
//      for (CollisionPair pair in pairs)
//      {
//        if (pair.GetContact() != null)
//        {
//          if (!pair.GetContact().IsResting)
//          {
//            if (min == null)
//            {
//              if (0.0 <= pair.GetContact().Dt && pair.GetContact().Dt < 1.0)
//              {
//                min = pair ;
//              }
//            }
//            else
//            {
//              if (pair.GetContact().Dt < min.GetContact().Dt)
//              {
//                min.Discard() ;
//                min = pair ;
//              }
//            }
//          }
//        }
//      }
//    }
    
    // resolve
    // - contact separation
    // - constaints
    for (int i=0; i<25; i++)
    {
      for (CollisionPair pair in pairs)
      {
        pair.GetContact().Separate(pair);
      }

      for (var constraint in constraints)
      {
        constraint.Resolve(i) ;
      }
    }

    // resolve contact forces
    for (CollisionPair pair in pairs)
    {
      pair.GetContact().Resolve(pair) ;
    }
  }
  
  void Draw(List<Particle> particles, List<Constraint> constraints, Renderer renderer)
  {
    for (var particle in particles)
    {
      String color ;
      
      if (particle.IsFixed)
      {
        color = "rgba(0, 0, 0, 0.5)" ;
      }
      else
      {
        int massColor = (255.0 * particle.MassInv).toInt() ;
        color = "rgba(${massColor}, 0, 0, 0.75)" ;
      }
      
      renderer.drawCircle(particle.Position, particle.Radius, color);
      
      // renderer.drawBox(particle.Box, "rgba(64, 64, 64, 1.0)") ;
      
      if (!IsRunning)
        renderer.drawVector(particle.Velocity * 10.0, particle.Position, "rgba(255, 128, 0, 0.5)") ;
    }
    
    for (var constraint in constraints)
    {
      constraint.Render(renderer) ;
    }
  }
  
  CollisionMap get Collisions => _collisionMap ;
}
