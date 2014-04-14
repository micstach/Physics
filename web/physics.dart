library physicsdemo;

import 'sample.scenes.dart' ;

import '../renderer/renderer.dart' ;
import 'renderer/canvas.software.renderer.dart' ;
// import 'renderer/canvas.webgl.renderer.dart' ;

import 'physics/scene.dart';
import 'physics/particle.dart';
import 'physics/simulation.dart';

import 'ui-tools/tool.dart';
import 'ui-tools/box.create.dart';
import 'ui-tools/particle.create.dart';
import 'ui-tools/constraint.create.dart';
import 'ui-tools/particle.draw.dart';
import 'ui-tools/particle.delete.dart';
import 'ui-tools/particle.select.dart';

import 'dart:html';
import 'package:json/json.dart' as JSON;

final InputElement slider = querySelector("#slider");
final Element details = querySelector("#details");
final Element position = querySelector("#position");

CanvasElement canvas = null ;

Scene scene = new Scene() ;

var colliding = new Set<Particle>() ;

Tool tool = null ;
Simulation simulation = null ;

final Element buttonTrigger = querySelector('button#trigger') ;
final Element buttonDrawFixed = querySelector('button#draw') ;
final Element buttonCreate = querySelector('button#create') ;
final Element buttonCreateBox = querySelector('button#createbox') ;
final Element buttonCreateConstraint = querySelector('button#create-constraint') ;
final Element buttonDelete = querySelector('button#delete') ;
final Element buttonSelect = querySelector('button#select') ;
final Element buttonSampleScene = querySelector('button#samplescene') ;
final Element buttonClearScene = querySelector('button#clearscene') ;

Renderer renderer = null ;

var breakOnCollision = false ;

void main() {
  
  canvas = querySelector("#canvas") ;
  
  buttonCreate.onClick.listen((e) => onCreateClicked(e)) ;
  buttonCreateBox.onClick.listen((e) => onCreateBoxClicked(e)) ;
  buttonCreateConstraint.onClick.listen((e) => onCreateConstraintClicked(e)) ;
  buttonDrawFixed.onClick.listen((e) => onDrawFixedClicked(e)) ;
  buttonDelete.onClick.listen((e) => onDeleteClicked(e)) ;
  buttonSelect.onClick.listen((e) => onSelectClicked(e)) ;
  
  buttonTrigger.onClick.listen((e) => onTriggerClicked(e)) ;
  
  buttonSampleScene.onClick.listen((e) => onSampleSceneClicked(e)) ;
  buttonClearScene.onClick.listen((e) => onClearSceneClicked(e)) ;
  querySelector('#savescene').onClick.listen((e) => onSaveSceneClicked(e)) ;
  querySelector('#loadscene').onClick.listen((e) => onLoadSceneClicked(e)) ;
  
  querySelector('#break-on-collision').onChange.listen((e) => onCheckChanged(e)) ;

  // create particle toolset
  tool = new CreateParticle(canvas, scene, 0.1) ;
  tool.Activate() ;
  
  simulation = new Simulation() ;

  renderer = new CanvasSoftwareRenderer(canvas) ;
  
  frameDraw(1);
}

void onCheckChanged(Event e)
{
  simulation.BreakOnCollision = ! simulation.BreakOnCollision  ;
}

num last = 0.0 ;
double _lastFps = 0.0 ;
double fps = 0.0 ;

/// Draw the complete figure for the current number of seeds.
void frameDraw(num delta) {
  window.animationFrame.then(frameDraw) ;

  renderer.clear() ;
  
  String detailsInnerHtml = "" ;
  detailsInnerHtml += "Fps: <b>${fps.toStringAsFixed(2)}</b>" + "<br/>" ;
  detailsInnerHtml += "Particles: <b>${scene.bodies.length}</b>" + "<br/>" ;
  detailsInnerHtml += "Constraints: <b>${scene.constraints.length}</b>" + "<br/>" ;
  if (scene.Collisions != null)
  {
    detailsInnerHtml += "Collision pairs: <b>${simulation.DetectedCollisionsCount.toString()}/${scene.Collisions.Pairs.length.toString()}</b>" ;
    detailsInnerHtml += "<br/>" ;
    detailsInnerHtml += "Collision detection time [%]: <b>${simulation.CollisionDetectionTime}</b>" ;
    detailsInnerHtml += "<br/>" ;
    detailsInnerHtml += "&nbsp query pairs [%]: <b>${simulation.QueryPairsTime}</b>" ;
    detailsInnerHtml += "<br/>" ;
    detailsInnerHtml += "&nbsp query min pairs [%]: <b>${simulation.QueryMinPairsTime}</b>" ;
    detailsInnerHtml += "<br/>" ;
    detailsInnerHtml += "Collision resolve time [%]: <b>${simulation.CollisionResolveTime}</b>" ;
  }
  
  details.innerHtml = detailsInnerHtml;
  
  colliding.clear();
  
  if (tool != null)
    tool.Draw(renderer) ;
  
  // simulate
  simulation.WorldWidth = canvas.clientWidth ;
  simulation.WorldHeight = canvas.clientHeight ;
 
  simulation.Run(scene) ;
  
  // draw
  scene.IsRunning = simulation.IsRunning ;
  scene.Render(renderer) ;
  
  querySelector("span#active-tool-description").text = tool.Name ;
  
  position.text = (tool.Position != null) ? "[${tool.Position.x}, ${tool.Position.y}]" : "" ;  

  fps = calculateFps(delta) ;
}

double calculateFps(num delta)
{
  if (last > 0.0)
  {
    double one_frame_time = (delta - last) / 10.0 ;
    double fps_counter = ((60.0 / (one_frame_time)) * 0.05) + (_lastFps * 0.95) ;
    
    last = delta ;
    _lastFps = fps_counter ;
    
    return fps_counter ;
  }
  else
  {
    last = delta ; 
  }
  
  return 0.0 ;
}

void onSampleSceneClicked(MouseEvent e)
{
  scene4(scene) ;
  
  simulation.Stop();
  buttonTrigger.text = "Play" ;
}

void onClearSceneClicked(MouseEvent e)
{
  scene.Clear() ;
}

void onSaveSceneClicked(MouseEvent e)
{
  save() ;
}

void onLoadSceneClicked(MouseEvent e)
{
  load() ;
  
  simulation.Stop();
  buttonTrigger.text = "Play" ;
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
  tool = new SelectParticle(canvas, scene, details) ;
  tool.Activate() ;
}

void onCreateClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new CreateParticle(canvas, scene, 0.1) ;
  tool.Activate() ;
}

void onCreateBoxClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new CreateBox(canvas, scene) ;
  tool.Activate() ;
}

void onCreateConstraintClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new CreateConstraint(canvas, scene) ;
  tool.Activate() ;
}

void onDrawFixedClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new DrawParticles(canvas, scene) ;
  tool.Activate() ;
}

void onDeleteClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new DeleteParticle(canvas, scene) ;
  tool.Activate() ;
}

void save()
{
  var jsonSceneString = JSON.stringify(scene.toJSON()) ;
  
  window.localStorage['scene'] =  jsonSceneString ;
}

void load()
{
  var jsonSceneString = window.localStorage['scene'] ;

  scene.readJSON(JSON.parse(jsonSceneString)) ;
}

