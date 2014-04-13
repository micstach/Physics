library boxcreate ;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart';

import '../physics/metabody1d.dart';
import '../physics/scene.dart';
import '../physics/body.dart';
import '../physics/particle.dart';
import '../physics/constraint.distance.dart';

import 'canvas.tool.dart' ;

import 'package:uuid/uuid_client.dart' ;
import 'dart:html';

class CreateBox extends CanvasTool
{
  Scene _scene ;
  
  Vec2 _start = null;
  Vec2 _end = null ;
  
  String _state = null ;
  String _guid = null ;
  
  CreateBox(CanvasElement canvas, this._scene) : super(canvas) 
  {
    _state = "set-start" ;
  }

  void OnMouseDown(MouseEvent e)
  {
    Vec2 point = Position ;
    if (_start == null)
    {
      _start = point ;
      _guid = (new Uuid()).v1().toString() ;
    }
  }
  
  void OnMouseUp(MouseEvent e)
  {
    Vec2 point = Position ;

    _end = point ;
    _createBox() ;
  }

  void OnMouseMove(MouseEvent e)
  {
    Vec2 point = Position ;
  }
  
  void Draw(Renderer renderer)
  {
    super.Draw(renderer) ;
    
    if (_start != null)
    {
      renderer.drawLine(_start, Position, "rgba(0, 0, 255, 0.5)") ;

      List<Body> p = _generateParticles(_start, Position) ;
            
      p[0].Render(renderer) ;
      p[1].Render(renderer) ;
      p[2].Render(renderer) ;
      p[3].Render(renderer) ;
      
      renderer.drawLine(p[0].Position, p[1].Position, "rgba(128, 128, 128, 0.5)") ;
      renderer.drawLine(p[1].Position, p[2].Position, "rgba(128, 128, 128, 0.5)") ;
      renderer.drawLine(p[2].Position, p[3].Position, "rgba(128, 128, 128, 0.5)") ;
      renderer.drawLine(p[3].Position, p[0].Position, "rgba(128, 128, 128, 0.5)") ;
    }
  }  
    
  void _createBox()
  {
    // box corners
    List<Body> p = _generateParticles(_start, _end) ;
    
    // box edges
    p.addAll(_createConstraintParticles(p[0], p[1])) ;
    p.addAll(_createConstraintParticles(p[1], p[2])) ;
    p.addAll(_createConstraintParticles(p[2], p[3])) ;
    p.addAll(_createConstraintParticles(p[3], p[0])) ;
    
    for (var i in p) 
      i.GroupName = _guid;
    
    _scene.bodies.addAll(p) ; 

    // box constraints - edges
    _scene.constraints.add(new ConstraintDistance(p[0],  p[1])) ;
    _scene.constraints.add(new ConstraintDistance(p[1],  p[2])) ;
    _scene.constraints.add(new ConstraintDistance(p[2],  p[3])) ;
    _scene.constraints.add(new ConstraintDistance(p[3],  p[0])) ;
   
    // box constraints - diagonals
    _scene.constraints.add(new ConstraintDistance(p[0], p[2])) ;
    _scene.constraints.add(new ConstraintDistance(p[1], p[3])) ;
    
    _start = null ;
    _end = null ;
  }
  
  List<Body> _generateParticles(Vec2 start, Vec2 end)
  {
    Vec2 d = end - start ;
    
    Vec2 pd = new Vec2(d.y, -d.x) ;
    
    Particle p1 = new Particle.fromVec2(start) ;
    p1.Mass = 1.0 ;
    p1.Velocity.Zero() ;
    
    Particle p2 = new Particle.fromVec2(start - pd) ;
    p2.Mass = 1.0 ;
    p2.Velocity.Zero() ;
    
    Particle p3 = new Particle.fromVec2(start - pd + d) ;
    p3.Mass = 1.0 ;
    p3.Velocity.Zero() ;
    
    Particle p4 = new Particle.fromVec2(start + d) ;
    p4.Mass = 1.0 ;
    p4.Velocity.Zero() ;
    
    return [p1, p2, p3, p4] ;
  }  
  
  List<Body> _createConstraintParticles(Particle a, Particle b)
  {
    List<Body> bodies = new List<Body>() ;
    
    double distance = (b.Position - a.Position).Length ;
    double distributableDistance = distance - a.Radius - b.Radius ;
    
    int items = (1 + (distributableDistance ~/ (a.Radius  + b.Radius)).toInt()) ;
    
    double step = distributableDistance / items ;
    
    double start = a.Radius;
    for (int i=0; i<items; i++)
    {
      double f = (start + step / 2.0) / distance;
      bodies.add(new MetaBody1D(a, b, f)) ;
      
      start += step ;
    }
    
    return bodies;
  }
  
  bool get IsActive => true ; 
  String get Name => "create box" ;
}