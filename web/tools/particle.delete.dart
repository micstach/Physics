library particle.delete;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart' ;
import '../../physics/particle.dart' ;
import 'tool.dart' ;

import 'dart:html';

class DeleteParticle extends Tool
{
  final CanvasElement _canvas ;
  List<Particle> _highlighted = null ;
  List<Particle> _particles = null ;
  
  MouseEvent _mouseEvent = null ;
  
  DeleteParticle(this._canvas, this._particles) 
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
    
    var delete = new List<Particle>() ;
    
    for (Particle p in _particles)
    {
      if ((p.Position - mouse).SqLength < (p.Radius * p.Radius))
      {
        delete.add(p) ;
      }
    }
    
    for (Particle p in delete)
    {
      _particles.remove(p) ;
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
    _highlighted.clear();
    
    if (_mouseEvent != null)
    {
      double x = _mouseEvent.layer.x.toDouble();
      double y = _canvas.clientHeight - _mouseEvent.layer.y.toDouble() ;
      
      Vec2 mouse = new Vec2(x, y) ;
      
      for (Particle p in _particles)
      {
        if ((p.Position - mouse).SqLength < (p.Radius * p.Radius))
          _highlighted.add(p) ;
      }
  
      for (var p in _highlighted)
      {
        renderer.drawBox(p.Box, "rgba(255, 0, 0, 1.0)") ;
      }
    }
  }
  
  String get Name => "click particle to delete" ;
}
