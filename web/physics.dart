library physicsdemo;

import '../math/vec2.dart';

import '../physics/contact.dart';
import '../physics/particle.dart';
import '../physics/collisionmap.dart';

import 'tools/createparticle.dart';

import 'dart:html';
import 'dart:math';

const String ORANGE = "orange";
const int SCALE_FACTOR = 4;
const num TAU = PI * 2;
const double DELTA_TIME = 0.1 ;

final InputElement slider = querySelector("#slider");
final Element notes = querySelector("#notes");
final Element details = querySelector("#details");

final num PHI = (sqrt(5) + 1) / 2;

final CanvasRenderingContext2D context = (querySelector("#canvas") as CanvasElement).context2D;

CanvasElement canvas = querySelector("#canvas") ;

var particles = new List<Particle>() ;
var colliding = new Set<Particle>() ;

var gravityForce = new Vec2(0.0, -9.81) ;

CreateParticle tool = null ;

void main() {

  // create particle toolset
  tool = new CreateParticle(canvas, particles, 0.1) ;
  tool.Activate() ;
  
  window.animationFrame.then(appLoop) ;
}


/// Draw the complete figure for the current number of seeds.
void appLoop(num delta) {
  context.clearRect(0, 0, canvas.clientWidth, canvas.clientHeight);
  
  notes.text = "${particles.length} particle(s)";
  
  colliding.clear();
  
  if (tool.IsActive)
  {
    tool.Render(drawSeed, drawPath, simulateParticles, detectCollisions, resolveCollisions) ;
  }
  else
  {
    colliding.clear();
    if (tool.GetParticlePath() != null)
    {
      drawPath(tool.GetParticlePath(), true) ;
    }
  }
  
  // simulate
  simulateParticles(particles);
  
  // draw
  for (var particle in particles)
  {
    drawSeed(particle);
    drawVector(particle.Position, particle.Velocity, 1.0) ;
  }
  
  window.animationFrame.then(appLoop) ;
}

double Impulse(double dt, double e, double relVel, double invMassA, double invMassB) 
{
    return ((1.0 + e) / (dt * dt * 0.5)) * (relVel / (invMassA + invMassB)) ;
}

void worldCollisionDetection(Particle particle)
{
  if (particle.IsFixed) return ;
  
  // world box collisions detection
  int PARTICLE_RADIUS = particle.Radius.toInt() ;
  
  if (particle.Position.x > canvas.clientWidth - PARTICLE_RADIUS)
  {
    particle.Velocity = Vec2.Reflect(particle.Velocity, new Vec2(-1.0, 0.0)).Neg();
    particle.Position = (new Vec2((canvas.clientWidth - PARTICLE_RADIUS).toDouble(), particle.Position.y)) ;
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
  
  if (particle.Position.y > canvas.clientHeight - PARTICLE_RADIUS)
  {
    particle.Velocity = Vec2.Reflect(particle.Velocity, new Vec2(0.0, -1.0)).Neg();
    particle.Position = (new Vec2(particle.Position.x, (canvas.clientHeight - PARTICLE_RADIUS).toDouble())) ;
  }
}

void simulateParticle(Particle particle)
{
  // action
  particle.AddForce(gravityForce * particle.Mass) ;
  
  particle.Integrate(DELTA_TIME) ;
  
  // reaction
  worldCollisionDetection(particle) ;  
}

void detectParticleCollisions(Particle particle, List particles, var collisionMap)
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

CollisionMap detectCollisions(List particles)
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
    
    detectParticleCollisions(a, collidable, collisionMap) ;
  }
  
  return collisionMap;
}

//void detectCollisions(List particles)
//{
//  // (!) dla kazdej pary trzeba wyznaczyc closest dt, roznica miedzy tym testem
//  // jest taka ze tam sprawdzam niefixed z reszta
//  // a tu moze byc kolejnosc inna
//  
//  for (int i=0; i<particles.length; i++)
//  {
//    detectParticleCollisions(particles[i], particles.getRange(i+1, particles.length).toList()) ;
//  }
//}

void simulateParticles(List particles)
{
  for (var particle in particles)
  {
    simulateParticle(particle);
  }
  
  CollisionMap map = detectCollisions(particles) ;
  
  resolveCollisions(map) ;
}

void resolveCollisions(CollisionMap collisionMap)
{
  Map<Particle, CollisionPair> minPairs = new Map<Particle, CollisionPair>() ;

  details.text = "" ; 

  CollisionPair minPair = null ;
  
  for (CollisionPair pair in collisionMap.Pairs)
  {
    if (0.0 <= pair.Dt && pair.Dt < 1.0)
    {
      colliding.add(pair.A) ;
      colliding.add(pair.B) ;
  
      details.text += (pair.Dt.toString() + ";") ;

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
    colliding.add(pair.A) ;
    colliding.add(pair.B) ;
    
    details.text += (" min = " + pair.Dt.toString()) ;

  }
}

/// Draw a small circle representing a seed centered at (x,y).
void drawSeed(Particle particle) {
  
  int PARTICLE_RADIUS = particle.Radius.toInt();
  double x = particle.Position.x ;
  double y = canvas.clientHeight - particle.Position.y ;
  
  var color = particle.IsFixed ? "black" : "orange" ;
  var isColliding = colliding.contains(particle) ;
  
  if (isColliding)
  {
    color = "green" ;  
  }
    
  context..beginPath()
         ..lineWidth = 2.0
         ..fillStyle = color 
         ..strokeStyle = color
         ..arc(x, y, PARTICLE_RADIUS, 0, TAU, false)
         ..fill()
         ..closePath()
         ..stroke();
}

void drawSeedColor(Particle particle, String color) {
  
  int PARTICLE_RADIUS = particle.Radius.toInt();
  double x = particle.Position.x ;
  double y = canvas.clientHeight - particle.Position.y ;
  
  context..beginPath()
         ..lineWidth = 2.0
         ..fillStyle = color 
         ..strokeStyle = color
         ..arc(x, y, PARTICLE_RADIUS, 0, TAU, false)
         ..fill()
         ..closePath()
         ..stroke();
}

var alphaValue = 0.75 ;

void drawPath(List points, bool created) {
   
  if (created)
  {
    alphaValue -= 0.001 ;
    if (alphaValue < 0.0)
      alphaValue = 0.0 ;
  }
  else
  {
    alphaValue = 0.75;
  }

  if (alphaValue > 0.0)
  {
    var white = "rgba(215, 215, 215, ${alphaValue})" ;
    var grayed = "rgba(162, 162, 162, ${alphaValue})" ;
    context.strokeStyle = grayed ;

    var value = 0 ;
    
    for (int i=0; i<points.length -1; i++)
    {
      context..beginPath()
      ..lineWidth = 1.0 ;
      num px = points[i].x ;
      num py = canvas.clientHeight - points[i].y ;
     
      context.strokeStyle = value % 2 == 0 ? white : grayed ;
      
      context.moveTo(px, py) ;
      px = points[i+1].x ;
      py = canvas.clientHeight - points[i+1].y ;
     
      context.lineTo(px, py) ;
      
      value++ ;
      context..stroke();
    }
    
    drawSeedColor(new Particle(points[points.length-1].x, points[points.length-1].y), "rgba(215, 0, 0, ${alphaValue})") ;
  }
}

void drawVector(Vec2 p, Vec2 v, double scale) {
  
  num px1 = p.x ;
  num py1 = p.y ;
  
  num px2 = p.x + v.x * scale ;
  num py2 = p.y + v.y * scale ;
  
  py1 = canvas.clientHeight - py1 ;
  py2 = canvas.clientHeight - py2 ;
  
  context..beginPath()
         ..lineWidth = 3
         ..fillStyle = ORANGE
         ..strokeStyle = ORANGE
         ..lineTo(px1, py1)
         ..lineTo(px2, py2)
         ..fill()
         ..closePath()
         ..stroke();
}
