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
  
  final Vec2 gravityForce = new Vec2(0.0, -9.81) ;

  // List<Particle> _particles = new List<Particle>() ;
  
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
    
    _resolveCollisions(map) ;
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
      CollisionPair collisionParams = collisionMap.Get(particle, p) ;
      
      Contact contact = Contact.Find(particle, p) ;

      if (contact != null)
      {
        collisionParams.AccumulateDt(contact.Dt) ;
      }
    }
  }

  CollisionMap _detectCollisions(List particles)
  {
    // (!) dla kazdej pary trzeba wyznaczyc closest dt, roznica miedzy tym testem
    // jest taka ze tam sprawdzam niefixed z reszta
    // a tu moze byc kolejnosc inna
    
    CollisionMap collisionMap = new CollisionMap(particles.length) ;
    
    for (int i=0; i<particles.length; i++)
    {
      var a = particles[i] ;
      
      List<Particle> collidable = new List<Particle>() ;
      
      for (int k=i+1; k<particles.length; k++)
      {
        collidable.add(particles[k]) ;
      }
      
      _detectParticleCollisions(a, collidable, collisionMap) ;
    }
    
    return collisionMap;
  }

  void _resolveCollisions(CollisionMap collisionMap)
  {
    Map<Particle, CollisionPair> minPairs = new Map<Particle, CollisionPair>() ;

    // details.text = "" ; 

    CollisionPair minPair = null ;
    
    for (CollisionPair pair in collisionMap.Pairs)
    {
      if (0.0 <= pair.Dt && pair.Dt < 1.0)
      {
        // colliding.add(pair.A) ;
        // colliding.add(pair.B) ;
        
        // details.text += (pair.Dt.toString() + ";") ;

        if (minPair == null)
          minPair = pair ;
        else
          if (minPair.Dt > pair.Dt)
            minPair = pair ;
        
//      for (Particle p in [pair.A, pair.B])
//      {
//        if (minPairs.containsKey(p))
//        {
//          if (pair.Dt < minPairs[p].Dt)
//          {
//            minPairs[p] = pair ;
//          }
//        }
//        else
//        {
//          minPairs[p] = pair ;
//        }
//      }
      }
    }
    
    Set<CollisionPair> mins = new Set<CollisionPair>() ;
    for (CollisionPair pair in minPairs.values)
      mins.add(pair) ;

        if (minPair != null)
        {
          // if (0.0 > pair.Dt || pair.Dt >= 1.0) continue ;
          var pair = minPair ;
          
          Particle a = pair.A ;
          Particle b = pair.B ;

          const bool solution = false ;
          
          if (solution)
          {
            a.Position = a.Position + a.Velocity * (-1.0 + pair.Dt) ; 
            b.Position = b.Position + b.Velocity * (-1.0 + pair.Dt) ;
            a.Velocity.Zero();
            b.Velocity.Zero();
            a.Mass = double.INFINITY ;
            b.Mass = double.INFINITY ;
          }
          else
          {
            a.Position = a.Position + a.Velocity * (-1.0 + pair.Dt) ; 
            b.Position = b.Position + b.Velocity * (-1.0 + pair.Dt) ;
            
            Vec2 rv = b.Velocity - a.Velocity ;
            Vec2 cn = (b.Position - a.Position).Normalize() ;
            
            if ((rv | cn) < 0.0)
            {
              double j = Impulse(DELTA_TIME, 0.5, (rv|cn), a.MassInv, b.MassInv) ;
              
              a.AddForce(cn * j) ;
              b.AddForce(cn * (-j)) ;
            }
          }
//    
          //colliding.add(pair.A) ;
          //colliding.add(pair.B) ;
          
          //details.text += (" min = " + pair.Dt.toString()) ;

        }
  }
  
  
}