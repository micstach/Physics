library phx.constraint.world ;

import '../math/vec2.dart' ;
import 'body.dart' ;
import 'metabody1d.dart';
import 'contact.dart' ;

Contact ResolveWorldConstraints(double e, Body body, int width, int height)
{
  if (body.IsFixed) return null ;
  
  if (body is MetaBody1D) return null ;
  
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
  int PARTICLE_RADIUS = body.Radius.toInt() ;
  
  if (body.Position.x > width - PARTICLE_RADIUS)
  {
    Vec2 n = new Vec2(-1.0, 0.0) ;
    double k = body.Velocity | n ;

    body.Velocity = body.Velocity - n * (k * (1.0 + e)) ;
    body.Position = (new Vec2((width - PARTICLE_RADIUS).toDouble(), body.Position.y)) ;
  }
  
  if (body.Position.x < 0.0 + PARTICLE_RADIUS)
  {
    Vec2 n = new Vec2(1.0, 0.0) ;
    double k = body.Velocity | n ;

    body.Velocity = body.Velocity - n * (k * (1.0 + e)) ;
    body.Position = (new Vec2((PARTICLE_RADIUS).toDouble(), body.Position.y)) ;
  }
  
  if (body.Position.y <= 0.0 + PARTICLE_RADIUS)
  {
    Vec2 n = new Vec2(0.0, 1.0) ;
    double k = body.Velocity | n ;
    
    body.Velocity = body.Velocity - n * (k * (1.0 + e)) ;
    body.Position = (new Vec2(body.Position.x, 0.0 + PARTICLE_RADIUS)) ;
  }
  
  if (body.Position.y > height - PARTICLE_RADIUS)
  {
    Vec2 n = new Vec2(0.0, -1.0) ;
    double k = body.Velocity | n ;

    body.Velocity = body.Velocity - n * (k * (1.0 + e)) ;
    body.Position = (new Vec2(body.Position.x, (height - PARTICLE_RADIUS).toDouble())) ;
  }
  
  return null ;
}