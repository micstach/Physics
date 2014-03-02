library physicsdemo;

import '../math/vec2.dart';

import '../physics/particle.dart';
import '../physics/simulation.dart';

import 'tools/createparticle.dart';

import 'dart:html';
import 'dart:math';

const String ORANGE = "orange";
const int SCALE_FACTOR = 4;
const num TAU = PI * 2;

final InputElement slider = querySelector("#slider");
final Element notes = querySelector("#notes");
final Element details = querySelector("#details");

final num PHI = (sqrt(5) + 1) / 2;

final CanvasRenderingContext2D context = (querySelector("#canvas") as CanvasElement).context2D;

CanvasElement canvas = querySelector("#canvas") ;

var particles = new List<Particle>() ;
var colliding = new Set<Particle>() ;

CreateParticle tool = null ;
Simulation simulation = null ;


void main() {

  // create particle toolset
  tool = new CreateParticle(canvas, particles, 0.1) ;
  tool.Activate() ;
  
  simulation = new Simulation() ;
  
  window.animationFrame.then(appLoop) ;
}


/// Draw the complete figure for the current number of seeds.
void appLoop(num delta) {
  context.clearRect(0, 0, canvas.clientWidth, canvas.clientHeight);
  
  notes.text = "${particles.length} particle(s)";
  
  colliding.clear();
  
  if (tool.IsActive)
  {
    tool.Render(drawSeed, drawPath) ;
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
  simulation.Simulate(particles) ;
  
  // draw
  for (var particle in particles)
  {
    drawSeed(particle);
    drawVector(particle.Position, particle.Velocity, 1.0) ;
  }
  
  window.animationFrame.then(appLoop) ;
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
