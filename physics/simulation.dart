library simulation ;

import "../math/vec2.dart" ;
import "particle.dart" ;
import 'collisionmap.dart';
import 'contact.dart';
import 'force.dart' ;
import 'gravity.dart' ;

class Simulation
{
  static const double DELTA_TIME = 0.1 ;

  List<Force> forces = new List<Force>() ;
  
  CollisionMap _collisionMap = null ;
  
  final Vec2 gravityForce = new Vec2(0.0, -9.81) ;

  Simulation() 
  {
    forces.add(new Gravity(new Vec2(0.0, -9.81))) ;
  }
      
  void _simulateParticle(Particle particle)
  {
    // action
    for (var force in forces)
    {
      force.Apply(particle) ;
    }
    
    particle.Integrate(DELTA_TIME) ;
    
    // reaction
    _worldCollisionDetection(particle) ;  
  }
  
  void Simulate(List particles)
  {
    for (var particle in particles)
    {
      _simulateParticle(particle);
    }
    
    CollisionMap map = _detectCollisions(particles) ;
    
    _resolveCollisions(particles, map) ;
  }
  
  
  int _worldWidth = 800 ;
  int _worldHeight = 600 ;
  
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

  double Impulse(double dt, double e, double relVel, double invMassA, double invMassB) 
  {
    return ((1.0 + e) / (dt * dt * 0.5)) * (relVel / (invMassA + invMassB)) ; 
  }

  void _detectParticleCollisions(Particle particle, List particles, var collisionMap)
  {
    for (var p in particles)
    {
      CollisionPair pair = collisionMap.Get(particle, p) ;
      
      if (pair != null)
      {
        Contact contact = Contact.Find(particle, p) ;
  
        pair.SetContact(contact) ;
      }
    }
  }

  CollisionMap _detectCollisions(List particles)
  {
    _collisionMap = new CollisionMap(particles.length) ;
    
    for (int i=0; i<particles.length; i++)
    {
      var a = particles[i] ;
      
      List<Particle> collidable = new List<Particle>() ;
      
      for (int k=i+1; k<particles.length; k++)
      {
        collidable.add(particles[k]) ;
      }
      
      _detectParticleCollisions(a, collidable, _collisionMap) ;
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
        if (pair.Details != null && pair.Details.IsResting == false)
        {
          if (min == null)
          {
            if (0.0 <= pair.Details.Dt && pair.Details.Dt < 1.0)
            {
              min = pair ;
            }
          }
          else
          {
            if (pair.Details.Dt < min.Details.Dt)
            {
              min = pair ;
            }
            else
            {
              
            }
          }
        }
      }
      
      if (min != null)
      {
        for (CollisionPair pair in pairs)
        {
          if (pair.Details != null && 
              pair.Details.IsResting == false && 
              min != pair)
          {
            pair.Discard() ;
          }
        }
      }
    }
    
    for (CollisionPair pair in collisionMap.Pairs)
    {
      if (pair.Details != null)
      {
        Particle a = pair.A ;
        Particle b = pair.B ;
  
        const bool solution = false ;
        
        if (!pair.Details.IsResting)
        {
          if (solution)
          {
              a.Position = a.Position + a.Velocity * (-1.0 + pair.Details.Dt) ; 
              b.Position = b.Position + b.Velocity * (-1.0 + pair.Details.Dt) ;
              a.Velocity.Zero();
              b.Velocity.Zero();
              a.Mass = double.INFINITY ;
              b.Mass = double.INFINITY ;
          }
          else
          {
            a.Position = a.Position + a.Velocity * (-1.0 + pair.Details.Dt) ; 
            b.Position = b.Position + b.Velocity * (-1.0 + pair.Details.Dt) ;
            
            Vec2 rv = b.Velocity - a.Velocity ;
            Vec2 cn = (b.Position - a.Position).Normalize() ;
            
            if ((rv | cn) < 0.0)
            {
              double j = Impulse(DELTA_TIME, 0.5, (rv|cn), a.MassInv, b.MassInv) ;
              
              a.AddForce(cn * j) ;
              b.AddForce(cn * (-j)) ;
            }
          }
        }
        else
        {
          a.Position = a.Position + a.Velocity * (-1.0 + pair.Details.Dt) ; 
          b.Position = b.Position + b.Velocity * (-1.0 + pair.Details.Dt) ;
          a.Velocity.Zero();
          b.Velocity.Zero();
        }
      }
    }
  }
  
  void Render(List<Particle> particles, var drawPoint, var drawVector)
  {
    for (var particle in particles)
    {
      drawPoint(particle);
      drawVector(particle.Position, particle.Velocity, 1.0) ;
    }
  }
  
  CollisionMap get Collisions => _collisionMap ;
}