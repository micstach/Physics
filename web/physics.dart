library physicsdemo;

import 'sample.scenes.dart' ;

import '../renderer/renderer.dart' ;
import 'renderer/canvas.software.renderer.dart' ;
import 'renderer/canvas.webgl.renderer.dart' ;

import 'physics/Body.dart';
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
final Element details = querySelector("#details");
final Element position = querySelector("#position");

CanvasElement canvas = null ;

List<Particle> particles = new List<Particle>() ;
List<Constraint> constraints = new List<Constraint>() ;
List<Body> bodies = new List<Body>() ;

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

Renderer renderer = null ;

var breakOnCollision = false ;

void main() {
  
  canvas = querySelector("#canvas") ;
  
  buttonCreate.onClick.listen((e) => onCreateClicked(e)) ;
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
  tool = new CreateParticle(canvas, particles, 0.1) ;
  tool.Activate() ;
  
  simulation = new Simulation() ;

  renderer = new CanvasSoftwareRenderer(canvas) ;

  window.animationFrame.then(frameDraw) ;
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

  renderer.clear() ;
  
  String detailsInnerHtml = "" ;
  detailsInnerHtml += "Fps: <b>${fps.toStringAsFixed(2)}</b>" + "<br/>" ;
  detailsInnerHtml += "Particles: <b>${particles.length}</b>" + "<br/>" ;
  detailsInnerHtml += "Constraints: <b>${constraints.length}</b>" + "<br/>" ;
  if (simulation.Collisions != null)
  {
    detailsInnerHtml += "Collision pairs: <b>${simulation.Collisions.DynamicCollisionsCount.toString()}/${simulation.Collisions.Pairs.length.toString()}</b>" ;
    detailsInnerHtml += "<br/>" ;
  }
  
  details.innerHtml = detailsInnerHtml;
  
  colliding.clear();
  
  if (tool != null)
    tool.Draw(renderer) ;
  
  // simulate
  simulation.WorldWidth = canvas.clientWidth ;
  simulation.WorldHeight = canvas.clientHeight ;
 
  simulation.Run(particles, constraints) ;
  
  // draw
  simulation.Draw(particles, constraints, renderer) ;
  
  // bodies
  for (Body body in bodies)
  {
    body.Render(renderer) ;
  }
  
  querySelector("span#active-tool-description").text = tool.Name ;
  
  position.text = (tool.Position != null) ? "[${tool.Position.x}, ${tool.Position.y}]" : "" ;  

  fps = calculateFps(delta) ;

  window.animationFrame.then(frameDraw) ;
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
  scene4(particles, constraints, bodies) ;
  
  simulation.Stop();
  buttonTrigger.text = "Play" ;
}

void onClearSceneClicked(MouseEvent e)
{
  particles.clear() ;
  constraints.clear() ;
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
  tool = new SelectParticle(canvas, details, particles) ;
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
  tool = new DrawParticles(canvas, particles, constraints) ;
  tool.Activate() ;
}

void onDeleteClicked(MouseEvent e)
{
  tool.Deactivate() ;
  tool = new DeleteParticle(canvas, particles, constraints) ;
  tool.Activate() ;
}

void save()
{
  var jsonParticles = [] ;
  
  for (Particle p in particles)
  {
    jsonParticles.add(p.toJSON()) ;
  }

  var jsonConstraints = [] ;
  for (Constraint constraint in constraints)
  {
    jsonConstraints.add(constraint.toJSON()) ;
  }
  
  var jsonScene = {'particles': jsonParticles, 'constraints': jsonConstraints} ;
  
  var jsonSceneString = JSON.stringify(jsonScene) ;
  
  window.localStorage['scene'] =  jsonSceneString ;
}

void load()
{
  var storageParticles = window.localStorage['scene'] ;
  
  if (storageParticles != null)
  {
    var jsonScene = JSON.parse(storageParticles) ;
    
    particles.clear() ;
    constraints.clear();
    simulation.Run(particles, constraints);
    
    var jsonParticles = jsonScene['particles'] ;
    
    Map<int, Particle> hashCodeMap = new Map<int, Particle>() ;
    
    for (var jsonParticle in jsonParticles)
    {
      Particle particle = new Particle.fromJSON(jsonParticle) ;
      
      hashCodeMap[jsonParticle['hash-code']] = particle ;
      
      particles.add(particle) ;
    }
    
    var jsonConstraints = jsonScene['constraints'] ;
    
    for (var jsonConstraint in jsonConstraints)
    {
      var type = jsonConstraint['type'] ;
      
      if (type == "distance")
      {
        int hashA = jsonConstraint['a'] ;
        int hashB = jsonConstraint['b'] ;
        
        constraints.add(new Distance(hashCodeMap[hashA], hashCodeMap[hashB])) ;
      }
    }
  }
}

