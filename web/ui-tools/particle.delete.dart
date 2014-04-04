library particle.delete;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart' ;

import '../physics/constraint.dart' ;
import '../physics/particle.dart' ;
import 'canvas.tool.dart' ;

import 'dart:html';

class DeleteParticle extends CanvasTool
{
  List<Particle> _highlighted = null ;
  List<Particle> _particles = null ;
  List<Constraint> _constraints = null ;
  
  DeleteParticle(CanvasElement canvas, this._particles, this._constraints) : super(canvas) 
  {
  }
  
  void OnClick(MouseEvent e)
  {
    Vec2 mouse = ConvertToWorldCoords(e) ;
    
    var delete_particles = new List<Particle>() ;
    
    for (Particle p in _particles)
    {
      if ((p.Position - mouse).SqLength < (p.Radius * p.Radius))
      {
        delete_particles.add(p) ;
      }
    }

    var delete_constraints = new List<Constraint>() ;
    
    for (Particle p in delete_particles)
    {
      for (Constraint c in _constraints)
      {
        if (c.A == p || c.B == p)
        {
          delete_constraints.add(c) ;
        }
      }
    }
    
    for (Constraint c in delete_constraints)
    {
      _constraints.remove(c) ;
    }
    
    for (Particle p in delete_particles)
    {
      _particles.remove(p) ;
    }
  }
  
  void OnDeactivate()
  {
    _highlighted = null ;
  }

  void OnActivate()
  {
    _highlighted = new List<Particle>() ;
  }
  
  void OnMouseMove(MouseEvent e)
  {
    _highlighted.clear();
    
    Vec2 mouse = ConvertToWorldCoords(e) ;
    
    for (Particle p in _particles)
    {
      if ((p.Position - mouse).SqLength < (p.Radius * p.Radius))
      {
        _highlighted.add(p) ;
      }
    }
  }
  
  bool get IsActive => false ;
  
  List<Particle> get Highlighted => _highlighted ;
  
  void Draw(Renderer renderer) 
  {
    for (var p in _highlighted)
    {
      renderer.drawBox(p.Box, "rgba(255, 0, 0, 1.0)") ;
    }
  }
  
  String get Name => "click particle to delete" ;
}
