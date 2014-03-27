library phx.constraint.world ;

import '../../math/vec2.dart' ;
import 'particle.dart' ;
import 'contact.dart' ;

Contact ResolveWorldConstraints(double e, Particle particle, int width, int height)
{
  if (particle.IsFixed) return null ;
  
  // bottom plane
//  Vec2 n = new Vec2(0.0, 1.0) ;
//  Vec2 p = new Vec2(0.0, 0.0) ;
//  if (particle.Velocity | n < 0.0)
//  {
//      Vec2 pa = particle.Position - particle.Velocity ;
//      Vec2 pb = particle.Position ;
//      
//      if (pa | n >= 0.0 && pb | n <= 0.0)
//      {
//        double k = (particle.Radius - (pa | n)) / (particle.Velocity | n) ;        
//        
//        return new CollidingContact(particle, null, k) ;
//      }
//  }
  
  // world box collisions detection
  int PARTICLE_RADIUS = particle.Radius.toInt() ;
  
  if (particle.Position.x > width - PARTICLE_RADIUS)
  {
    Vec2 n = new Vec2(-1.0, 0.0) ;
    double k = particle.Velocity | n ;

    particle.Velocity = particle.Velocity - n * (k * (1.0 + e)) ;
    particle.Position = (new Vec2((width - PARTICLE_RADIUS).toDouble(), particle.Position.y)) ;
  }
  
  if (particle.Position.x < 0.0 + PARTICLE_RADIUS)
  {
    Vec2 n = new Vec2(1.0, 0.0) ;
    double k = particle.Velocity | n ;

    particle.Velocity = particle.Velocity - n * (k * (1.0 + e)) ;
    particle.Position = (new Vec2((PARTICLE_RADIUS).toDouble(), particle.Position.y)) ;
  }
  
  if (particle.Position.y <= 0.0 + PARTICLE_RADIUS)
  {
    Vec2 n = new Vec2(0.0, 1.0) ;
    double k = particle.Velocity | n ;
    
    particle.Velocity = particle.Velocity - n * (k * (1.0 + e)) ;
    particle.Position = (new Vec2(particle.Position.x, 0.0 + PARTICLE_RADIUS)) ;
  }
  
  if (particle.Position.y > height - PARTICLE_RADIUS)
  {
    Vec2 n = new Vec2(0.0, -1.0) ;
    double k = particle.Velocity | n ;

    particle.Velocity = particle.Velocity - n * (k * (1.0 + e)) ;
    particle.Position = (new Vec2(particle.Position.x, (height - PARTICLE_RADIUS).toDouble())) ;
  }
  
  return null ;
}