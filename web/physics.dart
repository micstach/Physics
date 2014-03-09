library physicsdemo;

import 'renderer/canvasrenderer.dart' ;

import '../physics/particle.dart';
import '../physics/simulation.dart';

import 'tools/tool.dart';
import 'tools/particle.create.dart';
import 'tools/particle.delete.dart';

import 'dart:html';
import 'dart:math';
import 'package:json/json.dart' as JSON;

final InputElement slider = querySelector("#slider");
final Element notes = querySelector("#notes");
final Element details = querySelector("#details");
final Element position = querySelector("#position");

final num PHI = (sqrt(5) + 1) / 2;

CanvasElement canvas = null ;

var particles = new List<Particle>() ;
var colliding = new Set<Particle>() ;

Tool tool = null ;
Simulation simulation = null ;

final Element buttonCreate = querySelector('button#create') ;
final Element buttonDelete = querySelector('button#delete') ;

CanvasRenderer renderer = null ;

void main() {
  var scores = [{'score': 40}, {'score': 50}] ;
  var jsonText = JSON.stringify(scores) ;
  
  canvas = querySelector("#canvas") ;
  
  buttonCreate.onClick.listen((e) => onCreateClicked(e)) ;
  buttonDelete.onClick.listen((e) => onDeleteClicked(e)) ;
  
  // create particle toolset
  tool = new CreateParticle(canvas, particles, 0.1) ;
  tool.Activate() ;
  
  simulation = new Simulation() ;
  
  renderer = new CanvasRenderer(canvas) ;
  
  window.animationFrame.then(appLoop) ;
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

/// Draw the complete figure for the current number of seeds.
void appLoop(num delta) {
  
  renderer.clear() ;
  
  notes.text = "${particles.length} particle(s)";
  
  colliding.clear();
  
  if (tool != null)
    tool.Draw(renderer) ;
  
  // simulate
  simulation.Simulate(particles) ;
  
  // draw
  simulation.Draw(particles, renderer) ;
  
  querySelector("span#toolname").text = tool.Name ;
  
  details.text = "Collision pairs: " + simulation.Collisions.DynamicCollisionsCount.toString() + "/" + simulation.Collisions.Pairs.length.toString() ;
  
  if (tool.Position != null)
  {
    position.text = "Position (${tool.Position.x}, ${tool.Position.y})" ;  
  }
  
  window.animationFrame.then(appLoop) ;
}

