library pxh.simulation ;

import "../../renderer/renderer.dart" ;
import "../../math/vec2.dart" ;

import "particle.dart" ;
import 'collision.map.dart';
import 'collision.pair.dart';
import 'contact.dart';

import 'force.dart' ;
import 'force.gravity.dart' ;
import 'force.damping.dart' ;

import 'constraint.dart' ;
import 'constraint.world.dart' ;

class Simulation
{
  bool _breakOnCollision = false ;
  int _worldWidth ;
  int _worldHeight ;
  
  double _dt = 0.0 ;
  double _e = 0.25 ;

  List<Force> _forces = new List<Force>() ;
  
  CollisionMap _collisionMap = null ;
  
  final Vec2 gravityForce = new Vec2(0.0, -0.0981) ;

  Simulation() 
  {
    _forces.add(new Gravity(gravityForce)) ;
    
    _forces.add(new Damping(0.9999)) ;
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
  
  void Run(List<Particle> particles, List<Constraint> constraints)
  {
    if (!IsRunning) return ;
    
    for (var particle in particles)
    {
      _simulateParticle(particle);
    }

    // detect collisions
    Set<CollisionPair> pairs = _detectCollisions(particles, constraints) ;
    
    // resolve collisions
    _resolveCollisions(particles, constraints, pairs) ;

    for (var particle in particles)
    {
      ResolveWorldConstraints(_e, particle, _worldWidth, _worldHeight) ;
    }
    
    if (_breakOnCollision)
      if (pairs.length > 0) Stop();
  }
  
  Set<CollisionPair> _detectCollisions(List<Particle> particles, List<Constraint> constraints)
  {
    // refresh collision map
    if (_collisionMap == null)
      _collisionMap = new CollisionMap(particles, constraints) ;
    else 
      _collisionMap.Update(particles, constraints) ;
    
    _collisionMap.Reset() ;
    
    Set<CollisionPair> pairs = new Set<CollisionPair>() ;
    
    Map<Particle, List<CollisionPair>> particle_pairs = new Map<Particle, List<CollisionPair>>();
    
    for (CollisionPair pair in _collisionMap.Pairs)
    {
      Contact contact = Contact.Find(pair.A, pair.B) ;
      
      if (contact != null)
      {
        pair.SetContact(contact) ;
        pairs.add(pair) ;
        
        if (!contact.IsResting)
        {
          if (!particle_pairs.containsKey(pair.A))
            particle_pairs[pair.A] = new List<CollisionPair>() ;
          
          if (!particle_pairs.containsKey(pair.B))
            particle_pairs[pair.B] = new List<CollisionPair>() ;

          particle_pairs[pair.A].add(pair) ;
          particle_pairs[pair.B].add(pair) ;
        }
        else
        {
          pairs.add(pair) ;
        }
      }
    }

    for (Particle p in particle_pairs.keys)
    {
      if (p.IsFixed) continue ;
      
      List<CollisionPair> p_pairs = particle_pairs[p] ;
      
      CollisionPair min = null ;
      
      for (CollisionPair pair in p_pairs)
      {
        if (min == null)
        {
          if (pair.GetContact() != null)
            min = pair ;
        }
        else
        {
          if (pair.GetContact() != null)
          {
            if (min.GetContact().Dt > pair.GetContact().Dt)
            {
              min.Discard() ;
              min = pair ;
            }
            else
            {
              pair.Discard() ;
            }
          }
        }
      }
      
      if (min != null)
        if (min.GetContact() != null)
          pairs.add(min) ;
    }

    return pairs ;
  }

  void _resolveCollisions(List<Particle> particles, List<Constraint> constraints, Set<CollisionPair> contact_pairs)
  {
    // resolve
    // - contact separation
    // - constaints
    for (int i=0; i<25; i++)
    {
      for (CollisionPair pair in contact_pairs)
      {
        if (pair.GetContact() != null)
          pair.GetContact().Separate();
      }

      for (var constraint in constraints)
      {
        constraint.Resolve() ;
      }
    }

    // resolve contact forces
    if (contact_pairs.length > 0)
    {
      for (CollisionPair pair in contact_pairs)
      {
        if (pair.GetContact() != null)
          pair.GetContact().Resolve(_dt, _e) ;
      }
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
