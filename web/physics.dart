library physicsdemo;

import 'sample.scenes.dart' ;
import 'renderer/canvasrenderer.dart' ;

import 'physics/particle.dart';
import 'physics/simulation.dart';
import 'physics/constraint.dart' ;
import 'physics/constraint.distance.dart' ;

import 'ui-tools/tool.dart';
import 'ui-tools/particle.create.dart';
import 'ui-tools/constraint.create.dart';
import 'ui-tools/particle.draw.dart';
import 'ui-tools/particle.delete.dart';
import 'ui-tools/particle.select.dart';

import 'dart:html';
import 'package:json/json.dart' as JSON;

final InputElement slider = querySelector("#slider");
final Element notes = querySelector("#notes");
final Element details = querySelector("#details");
final Element position = querySelector("#position");
final Element collisions = querySelector("#collisions");
final Element fps = querySelector("#fps");

CanvasElement canvas = null ;

var particles = new List<Particle>() ;
List<Constraint> constraints = new List<Constraint>() ;

var colliding = new Set<Particle>() ;

Tool tool = null ;
Simulation simulation = null ;

final Element buttonTrigger = querySelector('button#trigger') ;
final Element buttonDrawFixed = querySelector('button#draw') ;
final Element buttonCreate = querySelector('button#create') ;
final Element buttonCreateConstraint = querySelector('button#create-constraint') ;
final Element buttonDelete = querySelector('button#delete') ;
final Element buttonSelect = querySelector('button#select') ;
final Element buttonSampleScene = querySelector('button#samplescene') ;
final Element buttonClearScene = querySelector('button#clearscene') ;

CanvasRenderer renderer = null ;

void main() {
  var scores = [{'score': 40}, {'score': 50}] ;
  var jsonText = JSON.stringify(scores) ;
  
  canvas = querySelector("#canvas") ;
  
  buttonCreate.onClick.listen((e) => onCreateClicked(e)) ;
  buttonCreateConstraint.onClick.listen((e) => onCreateConstraintClicked(e)) ;
  buttonDrawFixed.onClick.listen((e) => onDrawFixedClicked(e)) ;
  buttonDelete.onClick.listen((e) => onDeleteClicked(e)) ;
  buttonSelect.onClick.listen((e) => onSelectClicked(e)) ;
  
  buttonTrigger.onClick.listen((e) => onTriggerClicked(e)) ;
  
  buttonSampleScene.onClick.listen((e) => onSampleSceneClicked(e)) ;
  buttonClearScene.onClick.listen((e) => onClearSceneClicked(e)) ;
  
  // create particle toolset
  tool = new CreateParticle(canvas, particles, 0.1) ;
  tool.Activate() ;
  
  simulation = new Simulation() ;
  simulation.WorldWidth = canvas.clientWidth ;
  simulation.WorldHeight = canvas.clientHeight ;
  
  renderer = new CanvasRenderer(canvas) ;

  window.animationFrame.then(frameDraw) ;
}


num last = 0.0 ;
double _lastFps = 0.0 ;

/// Draw the complete figure for the current number of seeds.
void frameDraw(num delta) {

  renderer.clear() ;
  
  notes.text = "${particles.length} particle(s)";
  
  colliding.clear();
  
  if (tool != null)
    tool.Draw(renderer) ;
  
  // simulate
  simulation.Run(particles, constraints) ;
  
  // draw
  simulation.Draw(particles, constraints, renderer) ;
  
  
  // html
  querySelector("span#active-tool-description").text = tool.Name ;
  
  if (simulation.Collisions != null)
    details.text = "Collision pairs: " + simulation.Collisions.DynamicCollisionsCount.toString() + "/" + simulation.Collisions.Pairs.length.toString() ;
  
  position.text = (tool.Position != null) ? "[${tool.Position.x}, ${tool.Position.y}]" : "" ;  

  drawFps(delta) ;

  window.animationFrame.then(frameDraw) ;
}

void drawFps(num delta)
{
  if (last > 0.0)
  {
    double one_frame_time = (delta - last) / 20.0 ;
    double fps_counter = ((60.0 / (one_frame_time)) * 0.05) + (_lastFps * 0.95) ;
    
    fps.text = "FPS ${fps_counter.toStringAsFixed(2)}" ;
  
    last = delta ;
    _lastFps = fps_counter ;
  }
  else
    last = delta ;
}

void onSampleSceneClicked(MouseEvent e)
{
  scene1(particles, constraints) ;
}

void onClearSceneClicked(MouseEvent e)
{
  particles.clear() ;
  constraints.clear() ;
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

void onCreateConstraintClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new CreateConstraint(canvas, particles, constraints) ;
  tool.Activate() ;
}

void onDrawFixedClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new DrawParticles(canvas, particles, 0.1) ;
  tool.Activate() ;
}

void onDeleteClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new DeleteParticle(canvas, particles, constraints) ;
  tool.Activate() ;
}

