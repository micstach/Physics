library particle.select ;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart' ;

import '../physics/scene.dart' ;
import '../physics/body.dart' ;
import 'canvas.tool.dart' ;

import 'dart:html';

class SelectParticle extends CanvasTool
{
  final Element _output ; 
  List _highlighted = null ;
  Scene _scene ;
  List _tracked = new List() ;
  
  SelectParticle(CanvasElement canvas, Scene scene, this._output) : super(canvas)
  {
    _scene = scene ;
  }
  
  void OnClick(MouseEvent e)
  {
    Vec2 mouse = ConvertToWorldCoords(e);
  
    if (!e.ctrlKey)
    {
      _tracked.clear() ;
    }
    
    for (var body in _scene.bodies)
    {
      if ((body.Position - mouse).SqLength < (body.Radius * body.Radius))
      {
        _tracked.add(body) ;
      }
    }
  }
  
  void OnDeactivate()
  {
    _highlighted = new List() ;
  }

  void OnActivate()
  {
    _highlighted = new List() ;
  }
  
  bool get IsActive => false ;
  
  List<Body> get Highlighted => _highlighted ;
  
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
