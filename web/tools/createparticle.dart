library createparticle;

import 'tool.dart' ;

import '../../math/vec2.dart';
import '../../physics/particle.dart';
import '../../physics/simulation.dart';

import 'dart:html';

class CreateParticle implements Tool
{
  List _path = null ;
  final List _particles ;
  Particle _particle = null ;
  final CanvasElement _canvas ;
  final _velocityFactor ;
  
  CreateParticle(CanvasElement canvas, particles, velocityFactor)
      : _canvas = canvas
      , _velocityFactor = velocityFactor
      , _particles = particles 
  {
  }
  
  void Activate()
  {
    _canvas.onMouseDown.listen((e) => onMouseDown(e)) ;
    _canvas.onMouseMove.listen((e) => onMouseMove(e)) ;
    _canvas.onMouseUp.listen((e) => onMouseUp(e)) ;
    //_canvas.onKeyDown.listen((e) => onKeyDown(e));
    //_canvas.onKeyUp.listen((e) => onKeyUp(e));
    
    _canvas.onTouchStart.listen((e) => onTouchStart(e)) ;
    _canvas.onTouchMove.listen((e) => onTouchMove(e)) ;
    _canvas.onTouchEnd.listen((e) => onTouchEnd(e)) ;
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
  
  void Render(var drawParticle, var drawPath)
  {
    if (_particle == null) return ;
    
    // copy particles
    List<Particle> particles = new List<Particle>() ;
    for (Particle p in _particles)
      particles.add(new Particle.fromParticle(p)) ;
    
    particles.add(new Particle.fromParticle(_particle))  ;      

    _path = new List() ;
    _path.add(particles[particles.length-1].Position);
    
    var colliding = new Set<Particle>() ;
    var simulation = new Simulation() ;
    
    for (int i=0; i<1000; i++)
    {
      simulation.Simulate(particles) ;
      
      _path.add(particles[particles.length-1].Position);
    }

    drawPath(_path, false);
    drawParticle(_particle) ;
  }
  
}