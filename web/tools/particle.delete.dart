library particle.delete;

import '../../math/vec2.dart' ;
import '../../physics/particle.dart' ;
import 'tool.dart' ;

import 'dart:html';

class DeleteParticle extends Tool
{
  final CanvasElement _canvas ;
  List<Particle> _highlighted = null ;
  List<Particle> _particles = null ;
  
  DeleteParticle(this._canvas, this._particles) 
  {
  }
  
  void _onMouseMove(MouseEvent e) 
  {
    _highlighted.clear();
    
    double x = e.layer.x.toDouble();
    double y = _canvas.clientHeight - e.layer.y.toDouble() ;
    
    Vec2 mouse = new Vec2(x, y) ;
    
    for (Particle p in _particles)
    {
      if ((p.Position - mouse).SqLength < 1.0)
        _highlighted.add(p) ;
    }
  }
  
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
  
  void Render(var drawSeed, var drawPath) 
  {
  }
  
  String get Name => "delete particle" ;
}
