library particle.drawfixed;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart';
import '../physics/particle.dart';
import '../physics/constraint.dart';
import '../physics/constraint.distance.dart';

import 'tool.dart' ;

import 'dart:html';

class DrawParticles implements Tool
{
  double _alpha = 1.0 ;
  List _path = null ;
  final List _particles ;
  
  Particle _particle = null ;
  Particle _currentParticle = null ;
  Particle _previousParticle = null ;
  
  final CanvasElement _canvas ;
  final List<Constraint> _constraints ;
  MouseEvent _mouseEvent = null ;
  
  DrawParticles(CanvasElement canvas, particles, constraints)
      : _canvas = canvas
      , _constraints = constraints
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
  
  void addParticle(double mass)
  {
    if (_particle != null)
    {
      _particle.Mass = mass ;
      _particles.add(_particle) ;
      
      _previousParticle = _currentParticle ;
      _currentParticle = _particle ;
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
        
        if (e.shiftKey)
        {
          if (_previousParticle != null && _currentParticle != null)
            _constraints.add(new Distance(_previousParticle, _currentParticle)) ;
        }
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