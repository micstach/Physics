library particle.select ;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart' ;

import '../physics/particle.dart' ;
import 'canvas.tool.dart' ;

import 'dart:html';

class SelectParticle extends CanvasTool
{
  final Element _output ; 
  List<Particle> _highlighted = null ;
  List<Particle> _particles = null ;
  List<Particle> _tracked = new List<Particle>() ;
  
  SelectParticle(CanvasElement canvas, this._output, this._particles) : super(canvas)
  {
  }
  
  void OnClick(MouseEvent e)
  {
    Vec2 mouse = ConvertToWorldCoords(e);
  
    if (!e.ctrlKey)
    {
      _tracked.clear() ;
    }
    
    for (Particle p in _particles)
    {
      if ((p.Position - mouse).SqLength < (p.Radius * p.Radius))
      {
        _tracked.add(p) ;
      }
    }
  }
  
  void OnDeactivate()
  {
    _highlighted = new List<Particle>() ;
  }

  void OnActivate()
  {
    _highlighted = new List<Particle>() ;
  }
  
  bool get IsActive => false ;
  
  List<Particle> get Highlighted => _highlighted ;
  
  void Draw(Renderer renderer) 
  {
    for (var p in _tracked)
    {
      renderer.drawBox(p.Box, "rgba(255, 0, 0, 1.0)") ;
    }
    
    if (_output != null)
    {
      String info = "" ;
      
      for (var p in _tracked)
      {
        info += "Velocity: (${p.Velocity.x.toStringAsFixed(4)}, ${p.Velocity.y.toStringAsFixed(4)}) [${p.Velocity.Length.toStringAsFixed(4)}]" ;
        if (p.IsFixed)
          info += ", Mass: infinite" ;
        else
          info += ", Mass: ${p.Mass.toStringAsFixed(2)}" ;
        info += "<br/>" ;
      }
      
      _output.innerHtml += info ;    
    }
  }
  
  String get Name => "click particle to select" ;
}
