library particle.delete;

import "../renderer/renderer.dart" ;
import '../math/vec2.dart' ;

import '../physics/constraint.dart' ;
import '../physics/scene.dart' ;
import '../physics/body.dart' ;
import 'canvas.tool.dart' ;

import 'dart:html';

class DeleteParticle extends CanvasTool
{
  List<Body> _highlighted = null ;
  
  final Scene _scene ;
  
  DeleteParticle(CanvasElement canvas, this._scene) : super(canvas) 
  {
  }
  
  void OnClick(MouseEvent e)
  {
    Vec2 mouse = ConvertToWorldCoords(e) ;
    
    var delete_particles = new List<Body>() ;
    
    for (Body p in _scene.bodies)
    {
      if ((p.Position - mouse).SqLength < (p.Radius * p.Radius))
      {
        delete_particles.add(p) ;
      }
    }

    var delete_constraints = new List<Constraint>() ;
    
    for (Body p in delete_particles)
    {
      for (Constraint c in _scene.constraints)
      {
        if (c.A == p || c.B == p)
        {
          delete_constraints.add(c) ;
        }
      }
    }
    
    for (Constraint c in delete_constraints)
    {
      _scene.constraints.remove(c) ;
    }
    
    for (Body p in delete_particles)
    {
      _scene.bodies.remove(p) ;
    }
  }
  
  void OnDeactivate()
  {
    _highlighted = null ;
  }

  void OnActivate()
  {
    _highlighted = new List<Body>() ;
  }
  
  void OnMouseMove(MouseEvent e)
  {
    _highlighted.clear();
    
    Vec2 mouse = ConvertToWorldCoords(e) ;
    
    for (Body p in _scene.bodies)
    {
      if ((p.Position - mouse).SqLength < (p.Radius * p.Radius))
      {
        _highlighted.add(p) ;
      }
    }
  }
  
  bool get IsActive => false ;
  
  List<Body> get Highlighted => _highlighted ;
  
  void Draw(Renderer renderer) 
  {
    for (var p in _highlighted)
    {
      renderer.drawBox(p.Box, "rgba(255, 0, 0, 1.0)") ;
    }
  }
  
  String get Name => "Click on particle to delete it" ;
}
