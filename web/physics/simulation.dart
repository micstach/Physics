library simulation ;

import "../../renderer/renderer.dart" ;
import "../../math/vec2.dart" ;
import "particle.dart" ;
import 'collisionmap.dart';
import 'contact.dart';
import 'force.dart' ;
import 'gravity.dart' ;

class Simulation
{
  int _worldWidth ;
  int _worldHeight ;
  
  double _dt = 0.0 ;

  List<Force> forces = new List<Force>() ;
  
  CollisionMap _collisionMap = null ;
  
  final Vec2 gravityForce = new Vec2(0.0, -9.81) ;

  Simulation() 
  {
    forces.add(new Gravity(gravityForce)) ;
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
  
  void Simulate(List particles)
  {
    if (!IsRunning) return ;

    for (var particle in particles)
    {
      _simulateParticle(particle);
    }
    
    CollisionMap collisions = _detectCollisions(particles) ;
    
    _resolveCollisions(particles, collisions) ;
  }
  
  bool _isWorldCollisionDetection(Particle particle)
  {
    if (particle.IsFixed) return false ;
    
    // world box collisions detection
    int PARTICLE_RADIUS = particle.Radius.toInt() ;
    
    if (particle.Position.x > _worldWidth - PARTICLE_RADIUS)
    {
      return true ;
    }

    if (particle.Position.x < 0.0 + PARTICLE_RADIUS)
    {
      return true ;
    }

    if (particle.Position.y <= 0.0 + PARTICLE_RADIUS)
    {
      return true ;
    }
    
    if (particle.Position.y > _worldHeight - PARTICLE_RADIUS)
    {
      return true ;
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
      
//      if (min != null)
//      {
//        for (CollisionPair pair in pairs)
//        {
//          if (pair.GetContact() == null) continue ;
//          
//          if (pair.GetContact().IsResting == false && min != pair)
//          {
//            pair.Discard() ;
//          }
//        }
//      }
    }
    
    for (CollisionPair pair in collisionMap.Pairs)
    {
      if (pair.GetContact() == null) continue ;
      
      if (!pair.GetContact().IsResting)
        pair.GetContact().Resolve(pair.A, pair.B) ;
    }

    // separate objects
    for (int i=0; i<5; i++)
    {
      for (CollisionPair pair in collisionMap.Pairs)
      {
        if (pair.GetContact() == null) continue ;

        if (pair.GetContact().IsResting)
          pair.GetContact().Resolve(pair.A, pair.B);
      }
    }
    
    // project velocities
    for (CollisionPair pair in collisionMap.Pairs)
    {
      if (pair.GetContact() == null) continue ;

      if (pair.GetContact().IsResting)
      {
        Particle a = pair.A ;
        Particle b = pair.B ;
        
        Vec2 cn = (b.Position - a.Position).Normalize() ;
        
        a.Velocity = Vec2.Project(a.Velocity, cn);
        b.Velocity = Vec2.Project(b.Velocity, cn);
        
      }
    }
    
    
//    for (int j=0; j<particles.length; j++)
//    {
//      Particle a = particles[j] ;
//      
//    }
  }
  
  void Draw(List<Particle> particles, Renderer renderer)
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
  }
  
  CollisionMap get Collisions => _collisionMap ;
}
