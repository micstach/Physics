library particle.create;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart';
import '../physics/particle.dart';

import 'tool.dart' ;

import 'dart:html';

class CreateParticle implements Tool
{
  double _alpha = 1.0 ;
  List _path = null ;
  final List _particles ;
  Particle _particle = null ;
  final CanvasElement _canvas ;
  final _velocityFactor ;
  MouseEvent _mouseEvent = null ;
  
  CreateParticle(CanvasElement canvas, particles, velocityFactor)
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

//    _canvas.onTouchStart.listen((e) => onTouchStart(e)) ;
//    _canvas.onTouchMove.listen((e) => onTouchMove(e)) ;
//    _canvas.onTouchEnd.listen((e) => onTouchEnd(e)) ;
  }

  void Deactivate()
  {
    _onMouseDownStream.cancel() ;
    _onMouseMoveStream.cancel() ;
    _onMouseUpStream.cancel() ;

    //_canvas.onTouchStart.listen((e) => onTouchStart(e)) ;
    //_canvas.onTouchMove.listen((e) => onTouchMove(e)) ;
    //_canvas.onTouchEnd.listen((e) => onTouchEnd(e)) ;
  }

  void createParticle(double x, double y, double mass)
  {
    _particle = new Particle(x, y) ;
    _particle.Mass = mass ;
    _particle.Velocity.Zero() ;
  }
  
  void changeVelocity(Vec2 point, double mass)
  {
    if (_particle != null)
    {
      _particle.Mass = mass ;
      
      if (mass != double.INFINITY)
        _particle.Velocity = (point - _particle.Position) * (_velocityFactor) ;
      else
        _particle.Velocity.Zero() ;
    }
  }
  
  void addParticle(double mass)
  {
    if (_particle != null)
    {
      _particle.Mass = mass ;
      _particles.add(_particle) ;
    }
    
    _particle = null ;
  }
  
  void onMouseDown(MouseEvent e)
  {
    double x = e.layer.x.toDouble();
    double y = _canvas.clientHeight - e.layer.y.toDouble() ;
    
    createParticle(x, y, (e.ctrlKey) ? double.INFINITY : 1.0) ;
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
      _particle.Mass = 1.0 ;
    }
  }
  
  void onMouseMove(MouseEvent e)
  {
    _mouseEvent = e ;
    
    Vec2 point = new Vec2(e.layer.x.toDouble(), _canvas.clientHeight - e.layer.y.toDouble()) ;
    
    changeVelocity(point, (e.ctrlKey) ? double.INFINITY : 1.0) ;
  }

  void onMouseUp(MouseEvent e)
  {
    addParticle((e.ctrlKey) ? double.INFINITY : 1.0) ;
  }
  
  void onTouchStart(TouchEvent e)
  {
    double x = e.layer.x.toDouble();
    double y = _canvas.clientHeight - e.layer.y.toDouble() ;

    createParticle(x, y, (e.ctrlKey) ? double.INFINITY : 1.0) ;
  }

  void onTouchMove(TouchEvent e)
  {
    Vec2 point = new Vec2(e.layer.x.toDouble(), _canvas.clientHeight - e.layer.y.toDouble()) ;
    
    changeVelocity(point, (e.ctrlKey) ? double.INFINITY : 1.0) ;
  }

  void onTouchEnd(TouchEvent e)
  {
    addParticle((e.ctrlKey) ? double.INFINITY : 1.0) ;
  }

  bool get IsActive => _particle != null ; 
  
  List GetParticlePath() { return _path ; }
  
  SetParticlePath(List path) { _path = path ;}
  
  void Draw(Renderer renderer)
  {
    if (IsActive)
    {
      if (_particle == null) return ;
      
      // copy particles
      var particles = new List<Particle>() ;
      
      for (Particle p in _particles)
      {
        particles.add(new Particle.fromParticle(p)) ;
      }   
      particles.add(new Particle.fromParticle(_particle))  ;      

      _path = new List<Vec2>() ;
      _path.add(particles[particles.length-1].Position);
      
      /*var simulation = new Simulation() ;
      
      for (int i=0; i<1000; i++)
      {
        simulation.Simulate(particles) ;
        
        // last particle is our NEW particle
        _path.add(particles[particles.length-1].Position);
      }
      */
      _alpha = 0.75 ;
      
      renderer.drawCircle(_particle.Position, _particle.Radius, "rgba(255, 128, 128, ${_alpha})") ;
      renderer.drawPath(_path, false, "rgba(0, 0, 0, ${_alpha})", "rgba(192, 192, 192, ${_alpha})");
      renderer.drawCircle(_path[_path.length-1], _particle.Radius, "rgba(128, 128, 128, ${_alpha/2.0})") ;
    }
    else
    {
      if (_path != null)
      {
        if (_alpha > 0.0)
        {
          renderer.drawCircle(_path[_path.length-1], 10.0, "rgba(128, 128, 128, ${_alpha})") ;
          renderer.drawPath(_path, false, "rgba(0, 0, 0, ${_alpha})", "rgba(192, 192, 192, ${_alpha})");
        }
        _alpha -= 0.05 ;
        if (_alpha <= 0.0)
          _alpha = 0.0 ;
      }
    }
    
  }
  
  String get Name => "click and hold mouse button to create particle and set its velocity, user CTRL + click to create fixed particle " ;
  
  Vec2 get Position => _mouseEvent == null ? null : new Vec2(_mouseEvent.layer.x.toDouble(), _canvas.clientHeight - _mouseEvent.layer.y.toDouble()) ;
}