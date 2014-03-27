library particle.select ;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart' ;

import '../physics/particle.dart' ;
import 'tool.dart' ;

import 'dart:html';

class SelectParticle extends Tool
{
  final CanvasElement _canvas ;
  final Element _output ; 
  List<Particle> _highlighted = null ;
  List<Particle> _particles = null ;
  List<Particle> _tracked = new List<Particle>() ;
  
  MouseEvent _mouseEvent = null ;
  
  SelectParticle(this._canvas, this._output, this._particles) 
  {
  }
  
  void _onMouseMove(MouseEvent e) 
  {
    _mouseEvent = e ;
  }
  
  Vec2 get Position => _mouseEvent == null ? null : new Vec2(_mouseEvent.layer.x.toDouble(), _canvas.clientHeight - _mouseEvent.layer.y.toDouble()) ;
  
  void _onClick(MouseEvent e)
  {
    double x = e.layer.x.toDouble();
    double y = _canvas.clientHeight - e.layer.y.toDouble() ;
    
    Vec2 mouse = new Vec2(x, y) ;
  
    _tracked.clear() ;
    
    for (Particle p in _particles)
    {
      if ((p.Position - mouse).SqLength < (p.Radius * p.Radius))
      {
        _tracked.add(p) ;
      }
    }
  }
  
  var _onMouseMoveStream = null ; 
  var _onClickStream = null ;
  
  void Deactivate()
  {
    _onMouseMoveStream.cancel() ;
    _onClickStream.cancel() ;
    
    _highlighted = new List<Particle>() ;
  }

  void Activate()
  {
    _onMouseMoveStream = _canvas.onMouseMove.listen((e) => _onMouseMove(e)) ;
    _onClickStream = _canvas.onClick.listen((e) => _onClick(e)) ;
    
    _highlighted = new List<Particle>() ;
  }
  
  bool get IsActive => false ;
  
  List<Particle> get Highlighted => _highlighted ;
  
  void Draw(Renderer renderer) 
  {
    String info = "" ;
    for (var p in _tracked)
    {
      renderer.drawBox(p.Box, "rgba(255, 0, 0, 1.0)") ;
      info += "Velocity: (${p.Velocity.x.toStringAsFixed(4)}, ${p.Velocity.y.toStringAsFixed(4)}), length=${p.Velocity.Length.toStringAsFixed(4)}" ;
      if (p.IsFixed)
        info += ", Mass: ${p.Mass}" ;
      else
        info += ", Mass: ${p.Mass.toStringAsFixed(2)}" ;
          
    }
    
    if (_output != null)
      _output.text = info ;    
  }
  
  String get Name => "click particle to select" ;
}
