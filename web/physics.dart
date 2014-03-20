library physicsdemo;

import 'renderer/canvasrenderer.dart' ;

import 'physics/particle.dart';
import 'physics/simulation.dart';
import 'physics/collisionmap.dart' ;
import 'physics/constraint.dart' ;
import 'physics/constraint.distance.dart' ;

import 'tools/tool.dart';
import 'tools/particle.create.dart';
import 'tools/particle.delete.dart';
import 'tools/particle.select.dart';

import 'dart:html';
import 'dart:math';
import 'package:json/json.dart' as JSON;

final InputElement slider = querySelector("#slider");
final Element notes = querySelector("#notes");
final Element details = querySelector("#details");
final Element position = querySelector("#position");
final Element collisions = querySelector("#collisions");

final num PHI = (sqrt(5) + 1) / 2;

CanvasElement canvas = null ;

var particles = new List<Particle>() ;
List<Constraint> constraints = new List<Constraint>() ;

var colliding = new Set<Particle>() ;

Tool tool = null ;
Simulation simulation = null ;

final Element buttonTrigger = querySelector('button#trigger') ;
final Element buttonCreate = querySelector('button#create') ;
final Element buttonDelete = querySelector('button#delete') ;
final Element buttonSelect = querySelector('button#select') ;

CanvasRenderer renderer = null ;

void main() {
  var scores = [{'score': 40}, {'score': 50}] ;
  var jsonText = JSON.stringify(scores) ;
  
  canvas = querySelector("#canvas") ;
  
  buttonCreate.onClick.listen((e) => onCreateClicked(e)) ;
  buttonDelete.onClick.listen((e) => onDeleteClicked(e)) ;
  buttonSelect.onClick.listen((e) => onSelectClicked(e)) ;
  
  buttonTrigger.onClick.listen((e) => onTriggerClicked(e)) ;
  
  // create particle toolset
  tool = new CreateParticle(canvas, particles, 0.1) ;
  tool.Activate() ;
  
  simulation = new Simulation() ;
  simulation.WorldWidth = canvas.clientWidth ;
  simulation.WorldHeight = canvas.clientHeight ;
  
  renderer = new CanvasRenderer(canvas) ;

  double s = 25.0 ;
  double x = 400.0 ; 
  double y = 500.0 ; 
  int count = 15 ;

  Particle p1 = new Particle(x, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

  for (int i=1; i<=count; i++)
  {
    Particle p2 = new Particle(x + i * s, y) ;
    p2.Mass = (i==count) ? 1.0 : 1.0 ;
    p2.Velocity.Zero();
    particles.add(p2) ;
  
    constraints.add(new Distance(p1, p2)) ;
    
    p1 = p2 ;
  }
  
//  p1 = new Particle(x, y-100) ;
//  p1.Mass = double.INFINITY ;
//  p1.Velocity.Zero();
//  particles.add(p1) ;

 
  window.animationFrame.then(appLoop) ;
  //setTimeout(appLoop(0), 10000) ;
}

/// Draw the complete figure for the current number of seeds.
void appLoop(num delta) {
  
  renderer.clear() ;
  
  notes.text = "${particles.length} particle(s)";
  
  colliding.clear();
  
  if (tool != null)
    tool.Draw(renderer) ;
  
  // simulate
  simulation.Simulate(particles, constraints) ;
  
  // draw
  simulation.Draw(particles, constraints, renderer) ;
  
//  collisions.innerHtml = "" ;
//  if (simulation.Collisions != null)
//  {
//    for (CollisionPair collision in simulation.Collisions.Pairs)
//    {
//      if (collision.GetContact() != null)
//      {
//        collisions.innerHtml += collision.GetContact().Name ;
//        collisions.innerHtml += """<br />""" ;
//      }
//    }
//  }   
  
  querySelector("span#toolname").text = tool.Name ;
  
  if (simulation.Collisions != null)
    details.text = "Collision pairs: " + simulation.Collisions.DynamicCollisionsCount.toString() + "/" + simulation.Collisions.Pairs.length.toString() ;
  
  if (tool.Position != null)
  {
    position.text = "Position (${tool.Position.x}, ${tool.Position.y})" ;  
  }
  
  window.animationFrame.then(appLoop) ;
}

void onTriggerClicked(MouseEvent e)
{
  if (simulation != null)
  {
    if (simulation.IsRunning)
    {
      simulation.Stop();
      buttonTrigger.text = "Play" ;
    }
    else
    {
      simulation.Start() ;
      buttonTrigger.text = "Pause" ;
    }
  }
}

void onSelectClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new SelectParticle(canvas, collisions, particles) ;
  tool.Activate() ;
}

void onCreateClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new CreateParticle(canvas, particles, 0.1) ;
  tool.Activate() ;
}

void onDeleteClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new DeleteParticle(canvas, particles) ;
  tool.Activate() ;
}

