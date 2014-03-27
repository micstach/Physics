library particle.drawfixed;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart';
import '../physics/particle.dart';

import 'tool.dart' ;

import 'dart:html';

class DrawParticles implements Tool
{
  double _alpha = 1.0 ;
  List _path = null ;
  final List _particles ;
  Particle _particle = null ;
  final CanvasElement _canvas ;
  final _velocityFactor ;
  MouseEvent _mouseEvent = null ;
  
  DrawParticles(CanvasElement canvas, particles, velocityFactor)
      : _canvas = canvas
      , _velocityFactor = velocityFactor
      , _particles = particles 
  {
  }
  
  var _onMouseDownStream = null ;
  var _onMouseMoveStream = null ;
  var _onMouseUpStream = null ;
  
  void Activate()
  {
    _onMouseDownStream = _canvas.onMouseDown.listen((e) => onMouseDown(e)) ;
    _onMouseMoveStream = _canvas.onMouseMove.listen((e) => onMouseMove(e)) ;
    _onMouseUpStream = _canvas.onMouseUp.listen((e) => onMouseUp(e)) ;
  }

  void Deactivate()
  {
    _onMouseDownStream.cancel() ;
    _onMouseMoveStream.cancel() ;
    _onMouseUpStream.cancel() ;
  }

  void createParticle(double x, double y, double mass)
  {
    _particle = new Particle(x, y, 10.0) ;
    _particle.Mass = mass ;
    _particle.Velocity.Zero() ;
  }
  
//  void changeVelocity(Vec2 point, double mass)
//  {
//    if (_particle != null)
//    {
//      _particle.Mass = mass ;
//      
//      if (mass != double.INFINITY)
//        _particle.Velocity = (point - _particle.Position) * (_velocityFactor) ;
//      else
//        _particle.Velocity.Zero() ;
//    }
//  }
  
  void addParticle(double mass)
  {
    if (_particle != null)
    {
      _particle.Mass = mass ;
      _particles.add(_particle) ;
    }
    
    _particle = null ;
  }
  
  Vec2 _last = null ;
  void onMouseUp(MouseEvent e)
  {
    _last = null ;
  }
  
  void onMouseDown(MouseEvent e)
  {
    double x = e.layer.x.toDouble();
    double y = _canvas.clientHeight - e.layer.y.toDouble() ;
    
    createParticle(x, y, (e.ctrlKey) ? double.INFINITY : 1.0) ;
    addParticle((e.ctrlKey) ? double.INFINITY : 1.0) ;
    _last = new Vec2(x, y) ;    
  }

  void onKeyDown(KeyboardEvent e)
  {
    if (e.ctrlKey)
    {
      if (_particle != null)
      {
        _particle.Mass = (e.ctrlKey) ? double.INFINITY : 1.0 ;
      }
    }
  }
  
  void onKeyUp(KeyboardEvent e)
  {
    if (_particle != null)
    {
      _particle.Mass = 5.0 ;
    }
  }
  
  void onMouseMove(MouseEvent e)
  {
    _mouseEvent = e ;
    
    Vec2 point = new Vec2(e.layer.x.toDouble(), _canvas.clientHeight - e.layer.y.toDouble()) ;
    
    if (_last != null)
    {
      if ((_last-point).Length >= 20.0)
      {
        _last = point ;
        createParticle(point.x, point.y, (e.ctrlKey) ? double.INFINITY : 1.0) ;
        addParticle((e.ctrlKey) ? double.INFINITY : 1.0) ;
      }
    }
  }

  bool get IsActive => _particle != null ; 
  
  List GetParticlePath() { return _path ; }
  
  SetParticlePath(List path) { _path = path ;}
  
  void Draw(Renderer renderer)
  {
  }
  
  String get Name => "draw particles, press CTRL to draw fixed particles" ;
  
  Vec2 get Position => _mouseEvent == null ? null : new Vec2(_mouseEvent.layer.x.toDouble(), _canvas.clientHeight - _mouseEvent.layer.y.toDouble()) ;
}